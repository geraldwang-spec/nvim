vim.api.nvim_create_user_command('TestCommand',function()
  vim.notify("testQOO")
end,{})
