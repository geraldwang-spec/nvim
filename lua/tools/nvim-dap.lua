local status_ok, dap = pcall(require, "dap")
if not status_ok then
  vim.notify("load dap faily")
  return
end
print("test dap")
print(vim.fn.expand("%:p"))
dap.configurations.lua = {
  {
    name = 'Current file (local-lua-dbg, lua)',
    type = 'local-lua',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = {
      lua = 'lua5.1',
      file = '${file}',
    },
    args = {},
  },
}
