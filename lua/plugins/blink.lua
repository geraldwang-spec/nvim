return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = "rafamadriz/friendly-snippets",
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      -- ["<C-e>"] = { "hide", "fallback" },
      ["."] = { "show", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    completion = {
      menu = { border = "rounded" },
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
    },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
  },
}
