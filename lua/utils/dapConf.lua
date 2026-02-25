local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("dap fail")
  return
end

-- keymaps
vim.keymap.set("n", "dc", function()
  require("dap").continue()
end)
vim.keymap.set("n", "do", function()
  require("dap").step_over()
end)
vim.keymap.set("n", "di", function()
  require("dap").step_into()
end)
vim.keymap.set("n", "db", function()
  require("dap").toggle_breakpoint()
end)
-- vim.keymap.set({ "n", "v" }, "dh", function()
--   require("dap.ui.widgets").hover()
-- end)
-- vim.keymap.set({ "n", "v" }, "dp", function()
--   require("dap.ui.widgets").preview()
-- end)
-- vim.keymap.set("n", "df", function()
--   local widgets = require("dap.ui.widgets")
--   widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set("n", "ds", function()
--   local widgets = require("dap.ui.widgets")
--   widgets.centered_float(widgets.scopes)
-- end)
-- vim.keymap.set("n", "<F12>", function()
--   require("dap").step_out()
-- end)

-- 定義獲取當前工作目錄的函數
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
-- 1. 定義 Adapter (指向 Mason 的 debugpy)
dap.adapters.python = {
  type = "executable",
  command = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/debugpy/venv/bin/python"),
  args = { "-m", "debugpy.adapter" },
}

-- 2. 定義 Configuration (指向專案的 Python)
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = vim.fn.getcwd() .. "/src/pythonP/main.py",
    -- 這裡自動檢測專案有沒有 venv，有的話就用 venv 裡的 python 跑代碼
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "python3" -- 預設使用系統 python3
      end
    end,
  },
}
