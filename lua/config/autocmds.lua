-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local fn = vim.fn
local uv = vim.loop
local utils = require("utils.pyproject")

vim.api.nvim_create_user_command("NewPyProject", function(opts)
  local project_name = opts.args
  if project_name == "" then
    print("please enter project name")
    return
  end
  _G.NewPyProjectAuto(project_name)
end, { nargs = 1 })

-- 建立 Neovim command :PyInitRegen
vim.api.nvim_create_user_command("PyInitRegen", function(opts)
  local pkg = opts.args
  if pkg == "" or not pkg then
    print("❌ 請提供模組名稱，例如 :PyInitRegen mypkg")
    return
  end

  local cwd = fn.getcwd()
  local pkg_path = cwd .. "/src/" .. pkg

  if not uv.fs_stat(pkg_path) then
    print("❌ 模組不存在: " .. pkg_path)
    return
  end

  -- 重新生成 __init__.py
  utils.generate_init(pkg_path)
  print("✅ " .. pkg .. "/__init__.py 已重新生成")
end, {
  nargs = 1, -- 命令需要一個參數
  complete = "dir", -- 可選：用來做補完
})
