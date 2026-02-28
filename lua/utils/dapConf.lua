local M = {}

function M.config()
  local dap = require("dap")

  -- ... 這裡是你之前的 Adapter 和 Configuration 配置 ...
  -- --- 將快捷鍵放在這裡 ---
  -- 繼續/啟動
  vim.keymap.set("n", "dc", function()
    dap.continue()
  end, { desc = "DAP Continue" })
  -- 單步執行 (不進入函數)
  vim.keymap.set("n", "do", function()
    dap.step_over()
  end, { desc = "DAP Step Over" })
  -- 進入函數
  vim.keymap.set("n", "di", function()
    dap.step_into()
  end, { desc = "DAP Step Into" })
  -- 切換斷點
  vim.keymap.set("n", "db", function()
    dap.toggle_breakpoint()
  end, { desc = "DAP Toggle Breakpoint" })

  -- 建議加一個快捷鍵來關閉 Debug
  vim.keymap.set("n", "dq", function()
    dap.terminate()
  end, { desc = "DAP Terminate" })

  -- --- Python Adapter ---
  dap.adapters.python = {
    type = "executable",
    command = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/debugpy/venv/bin/python"),
    args = { "-m", "debugpy.adapter" },
  }

  -- --- Python Configuration ---
  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch Main File",
      -- 強制執行專案中的進入點
      -- program = vim.fn.getcwd() .. "/src/pythonP/main.py",
      program = function()
        local cwd = vim.fn.getcwd()
        -- vim.fs.find 會在指定路徑下搜尋符合檔名的檔案
        local found = vim.fs.find("main.py", {
          path = cwd,
          upward = false, -- 向下搜尋子目錄
          limit = 1, -- 找到第一個就停止
        })

        if #found > 0 then
          return found[1] -- 回傳找到的絕對路徑
        else
          -- 如果找不到，回退到當前檔案，並給個提示
          vim.notify("未找到 main.py，改為執行當前檔案", vim.log.levels.WARN)
          return vim.fn.expand("%:p")
        end
      end,
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        -- 修正：檢查 .venv (你的專案實際路徑)
        if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        else
          return "python3"
        end
      end,
      console = "integratedTerminal",
    },
  }

  local function get_project_root()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(current_buf)
    local current_dir = vim.fn.fnamemodify(current_file, ":p:h")

    -- 尋找包含 pubspec.yaml 的目錄
    local root_dir = current_dir
    while root_dir ~= "/" do
      if vim.fn.filereadable(root_dir .. "/pubspec.yaml") == 1 then
        return root_dir
      end
      root_dir = vim.fn.fnamemodify(root_dir, ":h")
    end

    return current_dir
  end

  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch dart",
      dartSdkPath = "/home/gerald/tools/development/flutter/bin/dart", -- ensure this is correct
      flutterSdkPath = "/home/gerald/tools/development/flutter/bin/flutter", -- ensure this is correct
      program = function()
        local root = get_project_root()
        return root .. "/lib/main.dart"
      end,
      cwd = get_project_root(),
    },
    {
      type = "flutter",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = "/home/gerald/tools/development/flutter/bin/dart", -- ensure this is correct
      flutterSdkPath = "/home/gerald/tools/development/flutter/bin/flutter", -- ensure this is correct
      program = function()
        local root = get_project_root()
        return root .. "/lib/main.dart"
      end,
      cwd = get_project_root(),
      args = function()
        -- 用户输入自定义参数，传递给 Flutter 调试器
        local input = vim.fn.input("Enter Flutter arguments (e.g., --flavor development): ")
        return vim.split(input, " ") -- 将参数按空格拆分成数组
      end,
    },
  }
  -- Dart CLI adapter (recommended)
  dap.adapters.dart = {
    type = "executable",
    command = "dart", -- if you're using fvm, you'll need to provide the full path to dart (dart.exe for windows users), or you could prepend the fvm command
    args = { "debug_adapter" },
    -- windows users will need to set 'detached' to false
    options = {
      detached = false,
    },
  }
  dap.adapters.flutter = {
    type = "executable",
    command = "flutter", -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
    args = { "debug_adapter" },
    -- windows users will need to set 'detached' to false
    options = {
      detached = false,
    },
  }
end

return M
