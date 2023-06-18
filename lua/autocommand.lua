vim.api.nvim_create_user_command('TestCommand',function()
  vim.notify("testQOO")
end,{})

vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
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

