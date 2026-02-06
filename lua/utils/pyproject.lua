local uv = vim.loop
local fn = vim.fn
local json = require("dkjson")

local pythonVer = "3.10"
local M = {}

-- 註冊新指令
-- vim.api.nvim_create_user_command("PyAddModule", M.add_module, {})

-- 輔助：寫入檔案
local function write_file(path, content)
  local f = io.open(path, "w")
  if f then
    f:write(content or "")
    f:close()
  end
end

-- 輔助：檢查執行檔
local function has_bin(bin)
  return vim.fn.executable(bin) == 1
end

function M.add_module()
  vim.ui.input({ prompt = "請輸入新模組名稱: " }, function(mod_name)
    if not mod_name or mod_name == "" then
      return
    end

    -- 1. 智慧偵測專案根目錄
    -- upward = true 表示往上找；stop 限制不要找過頭到系統根目錄
    local root_obj = vim.fs.find({ "pyproject.toml", ".git" }, {
      upward = true,
      stop = vim.loop.os_homedir(),
      path = vim.fn.expand("%:p:h"), -- 從目前編輯檔案的目錄開始找
    })

    local root_dir = (#root_obj > 0) and vim.fn.fnamemodify(root_obj[1], ":h") or vim.fn.getcwd()

    -- 2. 設定目標路徑
    local src_path = root_dir .. "/src"
    local target_path = src_path .. "/" .. mod_name

    -- 3. 強制檢查與自動修正
    -- 如果根目錄下沒有 src，問使用者是否要建立
    if vim.fn.isdirectory(src_path) == 0 then
      local confirm = vim.fn.input("找不到 src/ 資料夾，要在 " .. root_dir .. " 下建立嗎？(y/n): ")
      if confirm:lower() == "y" then
        vim.fn.mkdir(src_path, "p")
      else
        vim.notify("❌ 操作取消：找不到 src 資料夾", vim.log.levels.ERROR)
        return
      end
    end

    -- 4. 建立模組
    if vim.fn.isdirectory(target_path) == 1 then
      vim.notify("⚠️ 模組 " .. mod_name .. " 已存在！", vim.log.levels.WARN)
      return
    end

    vim.fn.mkdir(target_path, "p")
    local init_file = target_path .. "/__init__.py"
    write_file(init_file, "")

    vim.notify("✅ 模組已建立：" .. target_path, vim.log.levels.INFO)
    vim.cmd("edit " .. init_file)
  end)
end

function M.create_python_project()
  vim.ui.input({ prompt = "🚀 專案名稱: " }, function(name)
    if not name or name == "" then
      return
    end

    local cwd = vim.fn.getcwd()
    local root = cwd .. "/" .. name
    if vim.fn.isdirectory(root) == 1 then
      vim.notify("⚠️ 資料夾已存在！", vim.log.levels.WARN)
      return
    end

    -- 1. 建立目錄結構 (Source Layout)
    local src_root = root .. "/src"
    local main_pkg = src_root .. "/" .. name
    local module_pkg = src_root .. "/modules"
    local tests_dir = root .. "/tests"

    vim.fn.mkdir(root, "p")
    vim.fn.mkdir(main_pkg, "p")
    vim.fn.mkdir(module_pkg, "p")
    vim.fn.mkdir(tests_dir, "p")

    -- 2. 建立基礎檔案與 Pytest 範例
    write_file(main_pkg .. "/__init__.py", "")
    write_file(
      main_pkg .. "/main.py",
      "def add(a, b):\n    return a + b\n\nif __name__ == '__main__':\n    print(f'Sum: {add(1, 2)}')"
    )
    write_file(module_pkg .. "/__init__.py", "")

    -- 建立一個基礎測試檔案
    write_file(tests_dir .. "/__init__.py", "")
    write_file(
      tests_dir .. "/test_main.py",
      "from " .. name .. ".main import add\n\ndef test_add():\n    assert add(1, 2) == 3"
    )

    write_file(root .. "/README.md", "# " .. name)

    -- 3. 產生配置檔案 (Pyright & Pytest)
    -- pyrightconfig.json 確保 src 被視為 root
    local pyright_json = [[
{
  "include": ["src", "tests"],
  "venvPath": ".",
  "venv": ".venv",
  "extraPaths": ["./src"],
  "executionEnvironments": [
    {
      "root": "src"
    }
  ]
}
]]
    write_file(root .. "/pyrightconfig.json", pyright_json)

    -- 4. 初始化環境、安裝 pytest 並啟動
    local function finalize()
      vim.schedule(function()
        vim.api.nvim_set_current_dir(root)
        vim.notify("✅ 專案 " .. name .. " 與 Pytest 已就緒！", vim.log.levels.INFO)
        vim.cmd("LspRestart")
        vim.cmd("edit " .. main_pkg .. "/main.py")
      end)
    end

    if has_bin("uv") then
      vim.notify("使用 uv 初始化並安裝 pytest...", vim.log.levels.INFO)
      vim.system({ "uv", "init", "--lib", "--name", name }, { cwd = root }, function(obj)
        if obj.code == 0 then
          -- 加入 pytest 到 pyproject.toml 並設定配置
          local pytest_toml = '\n[tool.pytest.ini_options]\npythonpath = ["src"]\ntestpaths = ["tests"]\n'
          local f = io.open(root .. "/pyproject.toml", "a")
          if f then
            f:write(pytest_toml)
            f:close()
          end

          -- 安裝 pytest 並同步環境
          vim.system({ "uv", "add", "pytest", "--dev" }, { cwd = root }, function()
            vim.system({ "uv", "sync" }, { cwd = root }, finalize)
          end)
        end
      end)
    else
      vim.notify("use standard venv and starting ...", vim.log.levels.INFO)
      local base_toml = [[
[build-system]
requires = ["setuptools", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "]] .. name .. [["
version = "0.1.0"
dependencies = []
requires-python = ">=]] .. pythonVer .. [["

[tool.setuptools]
# 關鍵：告訴工具去 src 資料夾找代碼
package-dir = {"" = "src"}

[tool.pytest.ini_options]
pythonpath = ["src"]
testpaths = ["tests"]

[tool.pyright]
extraPaths = ["src"]
venvPath = "."
venv = ".venv"

[project.optional-dependencies]
dev = [
  "pyinstaller",
  "pytest",
]

]]
      write_file(root .. "/pyproject.toml", base_toml)
      write_file(root .. "/.gitignore", ".venv/\n__pycache__/\n.pytest_cache/\n*.egg-info/\n")

      -- building venv and execute develop mode install
      vim.system({ "python3", "-m", "venv", ".venv" }, { cwd = root }, function()
        -- 核心步驟：安裝 pytest 並將專案本身安裝為可編輯模式
        local pip_path = root .. "/.venv/bin/pip"
        vim.system({ pip_path, "install", "-e", ".", "pytest" }, { cwd = root }, finalize)
        vim.system({ pip_path, "install", "-e", ".", "pyinstaller" }, { cwd = root }, finalize)
      end)
      --
      -- -- 建立 venv 並安裝 pytest
      -- vim.system({ "python3", "-m", "venv", ".venv" }, { cwd = root }, function()
      --   -- 這裡需要使用該虛擬環境的 pip 來安裝 pytest
      --   local pip_path = root .. "/.venv/bin/pip"
      --   vim.system({ pip_path, "install", "pytest" }, {}, finalize)
      -- end)
    end
  end)
end

-- 主入口

return M
