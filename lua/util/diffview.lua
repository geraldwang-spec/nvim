local status_ok, diff = pcall(require, "diffview")
if not status_ok then
  return
end

local whichkey_ok, wk = pcall(require, "which-key")
if not whichkey_ok then
  return
end

wk.add({
  { "<leader>g", group = "git" },
  { "<leader>gD", group = "DiffView" },
  { "<leader>gDa", "<cmd>DiffviewFileHistory<cr>", desc = "File History All", mode = "n" },
  { "<leader>gDc", "<cmd>DiffviewClose<cr>", desc = "Close", mode = "n" },
  { "<leader>gDf", "<cmd>DiffviewFileHistory<cr>", desc = "File History", mode = "n" },
  { "<leader>gDF", "<cmd>DiffviewFocusFiles<CR>", desc = "Focus Files", mode = "n" },
  { "<leader>gDL", "<cmd>DiffviewLog<cr>", desc = "Log", mode = "n" },
  { "<leader>gDr", "<cmd>DiffviewRefresh<CR>", desc = "Refresh", mode = "n" },
  { "<leader>gDo", "<cmd>DiffviewOpen<cr>", desc = "Open", mode = "n" },
})
