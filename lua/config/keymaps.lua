-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- undotree
vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)
-- nvim-tree
vim.keymap.set("n", "<F2>", "<cmd>NvimTreeFindFileToggle<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-------------------------------------------------------------------
-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")

-- Insert --
-- Press jk fast to enter
vim.keymap.set("i", "jk", "<ESC>")

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

------------------------------------------------------------------
-- Terminal --
-- open termianl
vim.keymap.set("n", "<leader>t", ":edit term://bash<CR>")
--
-- Better terminal navigation
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")

--------------------------------------------------------------

--[[ vim.keymap.set("n", "<F2>", ":Lex 30<cr>", opts) ]]

vim.keymap.set("n", "qc", ":q!<CR>")
vim.keymap.set("n", "qa", ":wq<CR>")
-- show lau messages
vim.keymap.set("n", "<leader>d", ":messages<CR>")

-- ctrl k/j
vim.keymap.set("n", "<C-u>", "9k")
vim.keymap.set("n", "<C-n>", "9j")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

vim.keymap.set("n", "sc", "<C-w>c")
vim.keymap.set("n", "so", "<C-w>o")
vim.keymap.set("n", "sv", ":vsp<CR>")
vim.keymap.set("n", "sh", ":sp<CR>")

-- tab close
vim.keymap.set("n", "<A-q>", ":bd<CR>")
vim.keymap.set("n", "<A-q>c", ":bd!<CR>")

-- tab jump
-- it doesn't work when install nvim-tree and bufferline. I don't know why
--[[ vim.keymap.set("n", "<A-1>", "1gt", opts)
vim.keymap.set("n", "<A-2>", "2gt", opts)
vim.keymap.set("n", "<A-3>", "3gt", opts)
vim.keymap.set("n", "<A-4>", "4gt", opts)
vim.keymap.set("n", "<A-5>", "5gt", opts)
vim.keymap.set("n", "<A-6>", "6gt", opts)
vim.keymap.set("n", "<A-7>", "7gt", opts)
vim.keymap.set("n", "<A-8>", "8gt", opts)
vim.keymap.set("n", "<A-9>", "9gt", opts) ]]
---- tab jump
--vim.keymap.set("n", "<C-]>", "gt", opts)
--vim.keymap.set("n", "<C-[>", "gT", opts)

-- It is work-run for navigation tabs
vim.keymap.set("n", "<A-[>", "<cmd>bp<CR>")
vim.keymap.set("n", "<A-]>", "<cmd>bn<CR>")

--[[
-- Telescope
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
--vim.keymap.set("n", "<leader>ff", "<cmd>Telescope projects<cr>", opts)
--vim.keymap.set("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
vim.keymap.set("n", "<leader>g", ":lua require'telescope.builtin'.live_grep()<CR>", opts)
vim.keymap.set("n", "<leader>gg", ":lua require'telescope.builtin'.grep_string({search = vim.fn.expand(\"<cword>\")})<CR>", opts)
--vim.keymap.set("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- treesitter
vim.keymap.set("n", "tt", "<cmd>TSPlaygroundToggle<CR>", opts)
]]
------------------------------------------------------------------
vim.keymap.set("n", "<F3>", function()
  vim.cmd("/" .. vim.fn.expand("<cword>" .. vim.fn.expand("<cword>")))
end)

vim.keymap.set("n", "gb", "<C-o>") -- this is for lsp go back from definition
vim.keymap.del("i", "<Tab>")
vim.keymap.del("i", "<S-Tab>")
