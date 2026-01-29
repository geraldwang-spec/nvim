local uv = vim.loop
local fn = vim.fn
local json = require("dkjson")

local pythonVer = "3.10"
local M = {}
local function mkdir(path)
  if not uv.fs_stat(path) then
    uv.fs_mkdir(path, 448)
  end
end

local function touch(path)
  local f = io.open(path, "w")
  if f then
    f:close()
  end
end

local function list_py_files(dir)
  local files = {}
  local handle = uv.fs_scandir(dir)
  if not handle then
    return files
  end

  while true do
    local name, t = uv.fs_scandir_next(handle)
    if not name then
      break
    end

    if t == "file" and name:match("%.py$") and name ~= "__init__.py" and not name:match("^_") then
      table.insert(files, name)
    end
  end

  return files
end

local function parse_exports(file)
  local exports = {}

  for line in io.lines(file) do
    -- local fn = line:match("^def%s+([%w_]+)")
    -- local cls = line:match("^class%s+([%w_]+)")
    local fn = line:match("^%s*def%s+([%w_]+)")
    local cls = line:match("^%s*class%s+([%w_]+)")

    local name = fn or cls
    if name and not name:match("^_") then
      table.insert(exports, name)
    end
  end

  return exports
end

function M.generate_init(pkg_path)
  local py_files = list_py_files(pkg_path)

  local import_lines = {}
  local all_symbols = {}
  local seen = {}

  for _, file in ipairs(py_files) do
    local mod = file:gsub("%.py$", "")
    local fullpath = pkg_path .. "/" .. file
    local symbols = parse_exports(fullpath)

    if #symbols > 0 then
      table.insert(import_lines, string.format("from .%s import %s", mod, table.concat(symbols, ", ")))
      for _, s in ipairs(symbols) do
        if not seen[s] then
          seen[s] = true
          table.insert(all_symbols, s)
        end
      end
    end
  end

  local f = io.open(pkg_path .. "/__init__.py", "w")
  if not f then
    return
  end

  for _, l in ipairs(import_lines) do
    f:write(l .. "\n")
  end

  if #all_symbols > 0 then
    f:write("\n__all__ = [\n")
    for _, s in ipairs(all_symbols) do
      f:write(string.format('    "%s",\n', s))
    end
    f:write("]\n")
  end

  f:close()
end

-- 主入口
function M.NewPyProjectAuto(name)
  if not name or name == "" then
    print("❌ 請提供專案 / 套件名稱")
    return
  end

  local cwd = fn.getcwd()

  local is_project_root = uv.fs_stat(cwd .. "/pyproject.toml")
    and uv.fs_stat(cwd .. "/pyrightconfig.json")
    and uv.fs_stat(cwd .. "/src")

  local project_path = is_project_root and cwd or (cwd .. "/" .. name)
  local src_path = project_path .. "/src"
  local tests_path = project_path .. "/tests"
  local pkg_path = src_path .. "/" .. name

  -- === 建立目錄 ===
  mkdir(project_path)
  mkdir(src_path)
  mkdir(tests_path)
  mkdir(pkg_path)
  mkdir(pkg_path .. "/typestubs")

  if not uv.fs_stat(pkg_path .. "/__init__.py") then
    touch(pkg_path .. "/__init__.py")
  end
  touch(pkg_path .. "/typestubs/__init__.py")

  -- === pyproject.toml（只在新專案建立）===
  if not is_project_root then
    local pyproject = string.format([[
[project]
name = "%s"
version = "0.1.0"
description = ""
requires-python = ">=]] .. pythonVer .. [["

[tool.pytest.ini_options]
pythonpath = ["src"]
testpaths = ["tests"]

[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"
]], name)

    local f = io.open(project_path .. "/pyproject.toml", "w")
    if f then
      f:write(pyproject)
      f:close()
    end
  end

  -- === pyrightconfig.json（永遠覆寫，保持正確）===
  local pyright = {
    include = { "src", "tests" },
    pythonVersion = pythonVer,
    executionEnvironments = {
      { root = "src" },
    },
    typeCheckingMode = "standard",
    reportMissingTypeStubs = false,
  }

  local f = io.open(project_path .. "/pyrightconfig.json", "w")
  if f then
    f:write(json.encode(pyright, { indent = true }))
    f:close()
  end

  M.generate_init(pkg_path)

  print("✅ Python src-layout 專案就緒")
  print("   專案位置：" .. project_path)
  print("   套件名稱：" .. name)
end

_G.NewPyProjectAuto = M.NewPyProjectAuto

return M
