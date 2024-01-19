local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("telescope fail")
  return
end

local action_ok, fb_actions = pcall(require, "telescope._extensions.file_browser.actions")
if not action_ok then
  vim.notify("telescope file browser fail")
  return
end

vim.keymap.set('n', 'fb', "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>")

vim.keymap.set('n', 'ff', function()
  require('telescope.builtin').find_files()
end)

vim.keymap.set('n', 'fg', function()
  require('telescope.builtin').git_files()
end)

vim.keymap.set('n', 'fs', function()
        local opt = {
          -- cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
          search = vim.fn.expand("<cword>" .. vim.fn.expand("<cword>")),
        }
        require('telescope.builtin').grep_string(opt)
end)


--[[ local builtin = require('telescope.builtin'); ]]
--[[]]
--[[ vim.keymap.set('n', 'ff', builtin.find_files,{}) ]]
--[[ vim.keymap.set('n', 'fg', builtin.git_files,{}) ]]
--[[ vim.keymap.set('n', 'fs', function() ]]
--[[         local opt = { ]]
--[[           -- cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1], ]]
--[[           search = vim.fn.expand("<cword>" .. vim.fn.expand("<cword>")), ]]
--[[         } ]]
--[[         builtin.grep_string(opt) ]]
--[[ --        builtin.grep_string({ search = vim.fn.input("Grep > " .. aa)}); ]]
--[[ end) ]]

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = "= ",
    selection_caret = ">>",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-/>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- plea-se take a look at the readme of the extension you want to configure
   file_browser = {
      -- path
      -- cwd
      cwd_to_path = false,
      grouped = false,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = { file_browser = false, folder_browser = false },
      -- respect_gitignore
      -- browse_files
      -- browse_folders
      hide_parent_dir = false,
      collapse_dirs = false,
      prompt_path = false,
      quiet = false,
      dir_icon = "",
      dir_icon_hl = "Default",
      display_stat = { date = true, size = true, mode = true },
      hijack_netrw = false,
      use_fd = true,
      git_status = true,
      mappings = {
        ["i"] = {
          ["<A-c>"] = fb_actions.create,
          -- ["<S-CR>"] = fb_actions.create_from_prompt,
          ["<A-r>"] = fb_actions.rename,
          ["<A-m>"] = fb_actions.move,
          ["<A-y>"] = fb_actions.copy,
          ["<A-d>"] = fb_actions.remove,
          --["<C-o>"] = fb_actions.open,
          --["<C-g>"] = fb_actions.goto_parent_dir,
          --["<C-e>"] = fb_actions.goto_home_dir,
          --["<C-w>"] = fb_actions.goto_cwd,
          --["<C-t>"] = fb_actions.change_cwd,
          --["<C-f>"] = fb_actions.toggle_browser,
          --["<C-h>"] = fb_actions.toggle_hidden,
          --["<C-s>"] = fb_actions.toggle_all,
          --["<bs>"] = fb_actions.backspace,
        },
        ["n"] = {
          ["c"] = fb_actions.create,
          ["r"] = fb_actions.rename,
          ["m"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          --["o"] = fb_actions.open,
          --["g"] = fb_actions.goto_parent_dir,
          --["e"] = fb_actions.goto_home_dir,
          --["w"] = fb_actions.goto_cwd,
          --["t"] = fb_actions.change_cwd,
          --["f"] = fb_actions.toggle_browser,
          --["h"] = fb_actions.toggle_hidden,
          --["s"] = fb_actions.toggle_all,
        },
      },
    }, 
  },
}



