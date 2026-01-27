local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvimtree.setup({
  sort_by = "name",
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "h",
      info = "i",
      warning = "W",
      error = "E",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    --[[ height = 30, ]]
    --[[ hide_root_folder = false, ]]
    side = "left",
    --[[ auto_resize = true, ]]
    --[[ mappings = { ]]
    --[[ custom_only = false, ]]
    --[[ list = { ]]
    --[[ { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" }, ]]
    --[[ { key = "h", cb = tree_cb "close_node" }, ]]
    --[[ { key = "v", cb = tree_cb "vsplit" }, ]]
    --[[ }, ]]
    --[[ }, ]]
    number = false,
    relativenumber = false,
  },
  actions = {
    --[[ quit_on_open = true, ]]
    --[[ window_picker = { enable = true }, ]]
  },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":t",
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    --[[ symlink_destination = true, ]]
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "~",
        git = {
          unstaged = "|",
          staged = "+",
          unmerged = "]",
          renamed = "➜",
          deleted = "X",
          untracked = "✗",
          ignored = "◌",
        },
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
      },
    },
  },
})
