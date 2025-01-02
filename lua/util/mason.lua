local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("mason fail")
  return
end

local status_ok, masonlsp = pcall(require, "mason-lspconfig")
if not status_ok then
  vim.notify("mason-lspconfig fail")
  return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.notify("lspconfig fail")
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

masonlsp.setup({
  ensure_installed = {
    "pyright",
    "clangd",
    "csharp_ls",
    -- "dartls",
  },
  automatic_installation = true,
})
lspconfig.dartls.setup({})
-- lspconfig.dartls.setup({
--   cmd = { "dart", "language-server", "--protocol=lsp" },
--   filetypes = { "dart" },
--   init_options = {
--     closingLabels = true,
--     flutterOutline = true,
--     onlyAnalyzeProjectsWithOpenFiles = true,
--     outline = true,
--     suggestFromUnimportedLibraries = true,
--   },
--   settings = {
--     dart = {
--       completeFunctionCalls = true,
--       showTodos = true,
--     },
--   },
-- })
