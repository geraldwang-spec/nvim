-- Use <Tab> and <S-Tab> to navigate the completion list:
--vim.cmd('inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : \"\\<Tab>\"')
--vim.cmd('inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : \"\\<S-Tab>\"')

local fn = vim.fn

local install_path = fn.stdpath("data")..[[/site/pack/packer/start/coc.nvim]]
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify "coc can't found"
  return
end

-- auto install
local coc_extensions = {
  "coc-diagnostic",
  "coc-snippets",
  "coc-lua",
  "coc-sumneko-lua",
  "coc-pairs",
  "coc-html-css-support",
  "coc-html", 
  "coc-css",
  "coc-htmlhint",
  "coc-htmldjango",
  "coc-cmake",
  "coc-clangd",
  "coc-tsserver",
  "coc-json"
}
--
local coc_cmd = table.concat(coc_extensions, " ");
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"coc.lua"},
  command = "CocInstall "..coc_cmd,
})


local keyset = vim.keymap.set

local opts = {silent = true, noremap = true, expr = true}

-- Auto complete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
--keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation.
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window.
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


