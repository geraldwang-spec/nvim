-- Use <Tab> and <S-Tab> to navigate the completion list:
vim.cmd('inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : \"\\<Tab>\"')
vim.cmd('inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : \"\\<S-Tab>\"')
