vim.api.nvim_create_user_command('TestCommand',function()
  vim.notify("testQOO")
end,{})

--keymap("n", "sc", "<C-w>c", opts)

-- vim.keymap.set('n', '<F3>', function()
--   vim.cmd('vsp')
--   vim.cmd('copen')
--   -- local aa = vim.fn.expand("<cword>")
--   vim.notify('vimgrep ' .. vim.fn.expand("<cword>" .. vim.fn.expand("<cword>")) .. '  **.*.lua')
--   --vim.cmd('vimgrep ' .. aa .. '  **.*.lua')
-- vim.notify(aa)
-- 
-- end)
-- 
-- vim.api.nvim_create_user_command('VimgrepCloseSearch',function()
--   vim.cmd('cclose')
--   vim.cmd('close')
-- end,{})

