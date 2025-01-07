local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  vim.notify("load dap faily")
  return
end

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
  vim.notify("load dapui faily")
  return
end

dapui.setup()


-- print(vim.fn.expand("%:p"))
-- dap.configurations.lua = {
--   {
--     name = 'Current file (local-lua-dbg, lua)',
--     type = 'local-lua',
--     request = 'launch',
--     cwd = '${workspaceFolder}',
--     program = {
--       lua = 'lua5.1',
--       file = '${file}',
--     },
--     args = {},
--   },
-- }
