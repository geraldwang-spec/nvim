local M = {}

-- 全域自動安裝的 LSP
M.servers = {
  -- "pyright", -- Python
  "lua_ls", -- Lua
  "ts_ls", -- TypeScript / JavaScript
  -- "cmakelang",
  -- "cmakelint",
  -- "ast-grep",
  --"gopls", -- Go
  -- "stylua",
  -- "shellcheck",
  -- "shfmt",
  -- "flake8",
}

-- 需要特殊設定的 LSP
M.special_servers = {
  -- "clangd", -- 例如 C/C++ 需要特別 cmd 或 flags
  -- "dartls", -- Dart
  "basedpyright",
}

return M
