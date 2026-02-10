return {
  "michaelb/sniprun",
  build = "bash ./install.sh 1",
  keys = {
    { "f", "<Plug>SnipRun", mode = { "n", "v" }, desc = "Run snippet" },
    { "<leader>rh", "<Plug>SnipReset", desc = "Reset SnipRun (Restart Kernel)" },
    { "<leader>rq", "<Plug>SnipClose", desc = "關閉所有顯示" },
    { "<leader>rr", "<Plug>SnipReset", desc = "重置環境 (Reset)" },
  },
  opts = {
    display = {
      -- "VirtualTextOk", -- 簡單的結果直接顯示在行尾 (例如: => 42)
      "FloatingWindow", -- 較長的結果（如報錯或 List）彈出浮動視窗
    },
    display_options = {
      terminal_width = 45, -- 浮動視窗寬度
      notification_timeout = 5, -- 5 秒後自動關閉虛擬文字
    },
    -- 讓顯示視窗有點邊框，看起來更像現代 IDE
    floating_window_options = {
      border = "rounded",
      sync_cursor = true,
    },
  },
}
