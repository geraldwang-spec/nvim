local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("mason fail")
  return
end

local masonlsp_ok, masonlsp = pcall(require, "mason-lspconfig")
if not masonlsp_ok then
  vim.notify("mason-lspconfig fail")
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

local lsp_list = require("config.lsp_servers")

masonlsp.setup({
  ensure_installed = vim.list_extend(lsp_list.servers, lsp_list.special_servers),
  -- ensure_installed = {
  --   "pyright",
  --   "clangd",
  --   -- "csharp-language-server ",
  --   -- "dart-debug-adapter",<F2>
  --   -- "dartls",
  -- },
  automatic_installation = true,
})
local lsp_list = require("config.lsp_servers")
local blink_cmp = require("blink.cmp")
local lspconfig = require("lspconfig")

-- 🌟 全域自動 setup
for _, server in ipairs(lsp_list.servers) do
  lspconfig[server].setup({
    capabilities = blink_cmp.get_lsp_capabilities(),
  })
end

-- 🌟 特殊 LSP setup
lspconfig.clangd.setup({
  capabilities = blink_cmp.get_lsp_capabilities(),
  cmd = { "clangd", "--clang-tidy" },
  filetypes = { "c", "cpp" },
})

lspconfig.dartls.setup({
  capabilities = blink_cmp.get_lsp_capabilities(),
  -- 你可以在這裡加 Dart 特殊選項
})
