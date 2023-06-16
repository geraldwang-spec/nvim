local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--------------------------------------------------------------------

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)


-------------------------------------------------------------------
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

------------------------------------------------------------------
-- Terminal --
-- open termianl
keymap("n", "<leader>t", ":edit term://bash<CR>", opts)
--
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


--------------------------------------------------------------

--[[ keymap("n", "<F2>", ":Lex 30<cr>", opts) ]]

keymap("n", "qc", ":q!<CR>", opts)
keymap("n", "qa", ":wq<CR>", opts)
-- show lau messages
keymap("n", "<leader>d", ":messages<CR>", opts)

-- ctrl k/j
keymap("n", "<C-u>", "9k", opts)
keymap("n", "<C-n>", "9j", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "sc", "<C-w>c", opts)
keymap("n", "so", "<C-w>o", opts)
keymap("n", "sv", ":vsp<CR>", opts)
keymap("n", "sh", ":sp<CR>", opts)

-- tab close
keymap("n", "<A-q>", ":bd<CR>", opts)
-- tab jump
-- it doesn't work when install nvim-tree and bufferline. I don't know why
--[[ keymap("n", "<A-1>", "1gt", opts)
keymap("n", "<A-2>", "2gt", opts)
keymap("n", "<A-3>", "3gt", opts)
keymap("n", "<A-4>", "4gt", opts)
keymap("n", "<A-5>", "5gt", opts)
keymap("n", "<A-6>", "6gt", opts)
keymap("n", "<A-7>", "7gt", opts)
keymap("n", "<A-8>", "8gt", opts)
keymap("n", "<A-9>", "9gt", opts) ]]
---- tab jump
--keymap("n", "<C-]>", "gt", opts)
--keymap("n", "<C-[>", "gT", opts)

-- It is work-run for navigation tabs
keymap("n", "<A-[>", "<cmd>bp<CR>", opts)
keymap("n", "<A-]>", "<cmd>bn<CR>", opts)

--[[
-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
--keymap("n", "<leader>ff", "<cmd>Telescope projects<cr>", opts)
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>g", ":lua require'telescope.builtin'.live_grep()<CR>", opts)
keymap("n", "<leader>gg", ":lua require'telescope.builtin'.grep_string({search = vim.fn.expand(\"<cword>\")})<CR>", opts)
--keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- treesitter
keymap("n", "tt", "<cmd>TSPlaygroundToggle<CR>", opts)
]]
------------------------------------------------------------------


