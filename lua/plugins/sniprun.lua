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
      "Classic", -- 顯示在行尾的虛擬文字（適合看單行）
      "VirtualTextOk", -- 只在成功時顯示虛擬文字
      "FloatingWindow", -- 顯示完整輸出的浮動視窗
    },
    show_no_output = {
      "Classic",
      "FloatingWindow", -- 即使沒有 print 只有回傳值也顯示視窗
    },
    display_options = {
      terminal_width = 45, -- 浮動視窗寬度
      notification_timeout = 10, -- 5 秒後自動關閉虛擬文字
    },
    -- 讓顯示視窗有點邊框，看起來更像現代 IDE
    floating_window_options = {
      border = "rounded",
      sync_cursor = true,
    },
  },
}
