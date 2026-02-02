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

vim.api.nvim_create_user_command("PyProject", utils.create_python_project, {})
vim.api.nvim_create_user_command("PyAddModule", utils.add_module, {})
