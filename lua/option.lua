vim.opt.number = true
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.completeopt = {"menuone", "noselect"}	-- mostly just for cmp
vim.opt.fileencoding = "utf-8"			-- the encoding written to a file
vim.opt.hlsearch = true				-- hightlight all matches on previous search pattern
vim.opt.ignorecase = true			-- ignore case in search pattern
vim.opt.mouse = "a"				-- allow the mouse to be used in neovim
vim.opt.pumheight = 10				-- pop up menu height
vim.opt.showmode = true
vim.opt.showtabline = 2				-- always show tabs
vim.opt.smartcase = true			-- smart case
vim.opt.smartindent = true			-- make indenting smarter again
vim.opt.splitbelow = true			-- force all horizontal splits to go below window
vim.opt.splitright = true			-- force all vertical splites to go the right of current window
vim.opt.swapfile = false
vim.opt.termguicolors = true 		-- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 500			-- time to wait for a mapped sequence to complete (millisecond)
vim.opt.undofile = true 			-- enable persistent undo
vim.opt.updatetime = 300			-- faster completion(400ms default)
vim.opt.writebackup = false
vim.opt.expandtab = true			-- conver tabs to spaces
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true     -- hightlight the current line
vim.opt.relativenumber = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"        -- always showthe sign column, otherwise it would shift the text each time
vim.opt.wrap = false
vim.opt.colorcolumn = "200"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
--vim.opt.guifont = "Consolas:h12"
vim.opt.shortmess:append "c"
vim.o.autoread = true
vim.bo.autoread = true
vim.o.background = "dark"

vim.cmd([[highlight Pmenu ctermbg=Black ctermfg=White guibg=Black guifg=White]])
vim.cmd([[syntax on]])

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

-- airline
--vim.cmd([[let g:airline#etensions#tabline#enabled = 1]])
--vim.cmd([[let g:airline#etensions#tabline#left_sep = ' ']])
--vim.cmd([[let g:airline#etensions#tabline#left_alt_sep = '|']])

-- netrw
--[[ vim.cmd("let g:netrw_liststyle=3") ]]
--[[ vim.cmd("let g:netrw_browse_split=3") ]]

-- vim.cmd([[let g:python3_host_prog = 'C:\Python310\']])

