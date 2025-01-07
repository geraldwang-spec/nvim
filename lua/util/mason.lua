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
    -- "csharp-language-server ",
    -- "dart-debug-adapter",
    -- "dartls",
  },
  automatic_installation = true,
})

-- local signs = {
--
--   { name = "DiagnosticSignError", text = "E" },
--   { name = "DiagnosticSignWarn", text = "W" },
--   { name = "DiagnosticSignHint", text = "H" },
--   { name = "DiagnosticSignInfo", text = "I" },
-- }

-- for _, sign in ipairs(signs) do
--   vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
-- end

local config = {
  virtual_text = false, -- disable virtual text
  -- signs = {
  --   active = signs, -- show signs
  -- },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>") -- this is for lsp go back from definition

local opts = function()
  -- local keys = require("lazyvim.plugins.lsp.keymaps").get()
  -- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
  -- keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  -- keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
  -- keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  -- keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  -- keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  -- keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  -- keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

lspconfig.dartls.setup({ opts })
lspconfig.pyright.setup({ opts })
lspconfig.clangd.setup({ opts })
-- lspconfig.csharp_ls.setup({ opts })

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  vim.notify("cmp fail")
  return
end

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
})
