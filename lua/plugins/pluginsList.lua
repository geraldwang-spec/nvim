return {
  {
    "neovim/nvim-lspconfig",
  },
  {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-dap-python",
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
