local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data")..[[/site/pack/packer/start/packer.nvim]]
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print("Install packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])



local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("Load packer fail")
  return
end


-- Have packer use a popup window
packer.init{
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded"}
    end
  }
}


return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  --use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  --use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  ---- Colorshemes
  ----use "lunarvim/colorschemes" --- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

   -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- undotree
  use {'mbbill/undotree'} 
  

  ---- airline
  ----use "vim-airline/vim-airline"
  ----use "vim-airline/vim-airline-themes"
  --
  ---- LSP
  --use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  --use "neovim/nvim-lspconfig"           -- enable LSP

  ---- cmp plugins
  --use "hrsh7th/nvim-cmp"          --{ name = nvim_lsp}
  --use "hrsh7th/cmp-buffer"      --{ name = 'buffer'}
  --use "hrsh7th/cmp-path"        --{ name = 'path'}
  --use "hrsh7th/cmp-cmdline"     --{ name = 'cmdline'}
  --use "saadparwaiz1/cmp_luasnip" -- snippet completions
  --use "hrsh7th/cmp-nvim-lsp"
  --use "hrsh7th/cmp-nvim-lua"

  ---- snippets
  --use "L3MON4D3/LuaSnip" --snippet engine
  --use "rafamadriz/friendly-snippets" -- a bunch of snippets to use 

  ---- Telescope
  --use "nvim-telescope/telescope.nvim"
  --use 'nvim-telescope/telescope-media-files.nvim'

  -- -- Treesitter
  --use {
  --  "nvim-treesitter/nvim-treesitter",
  --  run = ":TSUpdate",
  --}
  --use "p00f/nvim-ts-rainbow"
  --use "nvim-treesitter/playground"

  ---- autopair
  --use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter

  ---- comment
  --use "numToStr/Comment.nvim" -- Easily comment stuff
  --use 'JoosepAlviste/nvim-ts-context-commentstring'

  ---- nvim tree
  --use 'kyazdani42/nvim-web-devicons'
  --use 'kyazdani42/nvim-tree.lua'
  --
  ---- bufferline
  --use "akinsho/bufferline.nvim"
  --use "moll/vim-bbye"

  ---- Null-ls
  --use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  ---- lualine
  --use "nvim-lualine/lualine.nvim"

  ---- toggleterm
  --use "akinsho/toggleterm.nvim"

  ---- Project
  --use "ahmedkhalf/project.nvim"

  ---- impatient
  --use "lewis6991/impatient.nvim"

  ---- indent
  --use "lukas-reineke/indent-blankline.nvim"

  ---- alpha
  --use 'goolord/alpha-nvim'
  --use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  ---- which key 
  --use "folke/which-key.nvim"



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)


