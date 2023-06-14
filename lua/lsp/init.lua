local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("lspconfig fail")
	return
end

require("lsp.mason")
require("lsp.handlers").setup()
require("lsp.null-ls")
