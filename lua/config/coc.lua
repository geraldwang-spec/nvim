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

local status_ok, toggleterm = pcall(require, "config.cockey")
if not status_ok then
  vim.notify "cockey can't found"
  return
end

