local uv = vim.loop
local fn = vim.fn
local json = require("dkjson")

-- 取得 src 下的所有子模組
local function list_submodules(src_path)
  local modules = {}
  local handle = uv.fs_scandir(src_path)
  if not handle then
    return modules
  end

  while true do
    local name, t = uv.fs_scandir_next(handle)
    if not name then
      break
    end
    if t == "directory" then
      table.insert(modules, name)
    end
  end
  return modules
end

-- 建立 __init__.py
local function touch_init(path)
  local f = io.open(path .. "/__init__.py", "w")
  if f then
    f:close()
  end
end

-- 主函式
function NewPyProjectAuto(name)
  if not name or name == "" then
    print("❌ 請提供名稱")
    return
  end

  local cwd = fn.getcwd()

  -- 判斷「目前目錄是不是 Python 專案根」
  local is_project_root = uv.fs_stat(cwd .. "/pyproject.toml") ~= nil
    and uv.fs_stat(cwd .. "/pyrightconfig.json") ~= nil
    and uv.fs_stat(cwd .. "/src") ~= nil

  local project_path
  local src_path
  local tests_path
  local module_name = name

  if is_project_root then
    -- 🟢 在現有專案中新增模組
    project_path = cwd
    src_path = cwd .. "/src"
    tests_path = cwd .. "/tests"

    if uv.fs_stat(src_path .. "/" .. module_name) then
      print("❌ src 下已存在模組：" .. module_name)
      return
    end
  else
    -- 🟡 建立新專案
    project_path = cwd .. "/" .. name
    src_path = project_path .. "/src"
    tests_path = project_path .. "/tests"

    if uv.fs_stat(project_path) then
      print("❌ 專案已存在：" .. project_path)
      return
    end

    uv.fs_mkdir(project_path, 448)
    uv.fs_mkdir(src_path, 448)
    uv.fs_mkdir(tests_path, 448)

    -- pyproject.toml
    local pyproject = string.format(
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
  "src/**/typestubs"
]
pythonVersion = "3.10"
pythonPlatform = "Linux"

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"
]],
      name
    )

    local f = io.open(project_path .. "/pyproject.toml", "w")
    if f then
      f:write(pyproject)
      f:close()
    end
  end

  -- 建立模組本體
  local mod_path = src_path .. "/" .. module_name
  uv.fs_mkdir(mod_path, 448)
  uv.fs_mkdir(mod_path .. "/typestubs", 448)
  touch_init(mod_path)
  touch_init(mod_path .. "/typestubs")

  -- 重新掃描 src
  local modules = list_submodules(src_path)

  -- 建立 executionEnvironments
  local executionEnvs = {}
  local extra_paths = {}

  for _, mod in ipairs(modules) do
    local p = "src/" .. mod
    table.insert(extra_paths, p)
    table.insert(executionEnvs, {
      root = p,
      pythonVersion = "3.10",
      extraPaths = { p },
      typeCheckingMode = "strict",
    })
  end

  -- tests environment（一定有 extraPaths）
  table.insert(executionEnvs, {
    root = "tests",
    pythonVersion = "3.10",
    extraPaths = extra_paths,
    typeCheckingMode = "strict",
  })

  -- pyrightconfig.json
  local pyright = {
    typeCheckingMode = "standard",
    autoSearchPaths = true,
    useLibraryCodeForTypes = true,
    reportMissingImports = "error",
    reportMissingTypeStubs = false,
    stubPath = "src/" .. module_name .. "/typestubs",
    executionEnvironments = executionEnvs,
  }

  local f = io.open(project_path .. "/pyrightconfig.json", "w")
  if f then
    f:write(json.encode(pyright, { indent = true }))
    f:close()
  end

  -- 新專案才跑 poetry
  if not is_project_root then
    os.execute(string.format("cd %s && poetry install", project_path))
  end

  print("✅ 完成")
  print("   模組：" .. module_name)
  print("   專案位置：" .. project_path)
end

_G.NewPyProjectAuto = NewPyProjectAuto
