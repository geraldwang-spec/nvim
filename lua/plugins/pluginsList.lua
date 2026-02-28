return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("utils.dapConf").config()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {}, -- 使用預設值，解決 Missing fields 警告
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)

      -- 建立自動彈出 UI 的監聽器
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "sindrets/diffview.nvim",
  },
  -- flutter-tools
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = true,
  },
  {
    "dimaportenko/telescope-simulators.nvim",
  },
  -- undotree
  { "mbbill/undotree" },
  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
  },
  -- telescope-plug
  {
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.8",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
    {
      "nvim-telescope/telescope-project.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
    },
  },
  -- luaroks
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "LuaDist/dkjson",
    lazy = false,
    config = function()
      print("dkjson loaded")
    end,
  },
}
