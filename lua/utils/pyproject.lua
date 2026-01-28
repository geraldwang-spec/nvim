local uv = vim.loop
local fn = vim.fn
-- local json = vim.fn.json_encode
local json = require("dkjson")

-- Helper: 取得 src 下子模組
local function list_submodules(src_path)
  local modules = {}
  local handle = uv.fs_scandir(src_path)
  if handle then
    while true do
      local name, type = uv.fs_scandir_next(handle)
      if not name then
        break
      end
      if type == "directory" then
        table.insert(modules, name)
      end
    end
  end
  return modules
end

function NewPyProjectAuto(project_name)
  if not project_name or project_name == "" then
    print("請提供專案名稱")
    return
  end

  local cwd = fn.getcwd()
  local project_path = cwd .. "/" .. project_name

  if uv.fs_stat(project_path) then
    print("專案已存在: " .. project_path)
    return
  end

  -- 1️⃣ 建立目錄
  uv.fs_mkdir(project_path, 448)
  uv.fs_mkdir(project_path .. "/src", 448)
  uv.fs_mkdir(project_path .. "/tests", 448)

  -- 先建立 pyproject.toml
  local pyproject_file = project_path .. "/pyproject.toml"
  local pyproject_content = string.format(
    [[
[tool.poetry]
name = "%s"
version = "0.1.0"
description = ""
authors = ["Gerald Wang <gerald@example.com>"]

[tool.poetry.dependencies]
python = "^3.10"

[tool.poetry.dev-dependencies]
pytest = "^7.0"

[tool.pyright]
include = ["src"]
exclude = [
  "**/node_modules",
  "**/__pycache__",
  "src/experimental",
  "src/typestubs"
]
pythonVersion = "3.10"
pythonPlatform = "Linux"

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"
]],
    project_name
  )

  local f = io.open(pyproject_file, "w")
  if f then
    f:write(pyproject_content)
    f:close()
  end

  -- 2️⃣ 掃描 src/ 子模組，建立 typestubs + executionEnvironments
  local src_path = project_path .. "/src"
  local modules = list_submodules(src_path)
  local executionEnvs = {}
  local extra_paths = {}
  for _, mod in ipairs(modules) do
    uv.fs_mkdir(src_path .. "/" .. mod .. "/typestubs", 448)
    table.insert(executionEnvs, {
      root = "src/" .. mod,
      pythonVersion = "3.10",
      extraPaths = { "src/" .. mod },
      typeCheckingMode = "strict",
    })
    table.insert(extra_paths, "src/" .. mod)
  end

  -- 對 tests 也生成 environment
  table.insert(executionEnvs, {
    root = "tests",
    pythonVersion = "3.10",
    -- extraPaths = modules, -- tests 可以 import 所有 src 子模組
    extraPaths = extra_paths,
    typeCheckingMode = "strict",
  })

  -- 3️⃣ pyrightconfig.json (包含 executionEnvironments)
  local pyright_json_file = project_path .. "/pyrightconfig.json"
  local pyright_config = {
    typeCheckingMode = "standard",
    autoSearchPaths = true,
    useLibraryCodeForTypes = true,
    reportMissingImports = "error",
    reportMissingTypeStubs = false,
    stubPath = "src/" .. (modules[1] or project_name) .. "/typestubs",
    executionEnvironments = executionEnvs,
  }

  local json_str = json.encode(pyright_config, { indent = true })
  local f = io.open(pyright_json_file, "w")
  if f then
    f:write(json_str)
    f:close()
  else
    print("fail loaded " .. pyright_json_file)
  end

  -- local fjson = io.open(pyright_json_file, "w")
  -- if fjson then
  --   fjson:write(vim.fn.json_encode(pyright_config))
  --   fjson:close()
  -- end

  -- 4️⃣ 初始化 Poetry 虛擬環境
  os.execute(string.format("cd %s && poetry install", project_path))

  print("✅ 進階自動專案生成完成: " .. project_path)
  print("   - pyproject.toml (通用設定)")
  print("   - pyrightconfig.json (LSP override + executionEnvironments)")
  print("   - src/ + typestubs + tests/")
  print("   - Poetry 虛擬環境已建立")
end

-- 全域函式
_G.NewPyProjectAuto = NewPyProjectAuto
