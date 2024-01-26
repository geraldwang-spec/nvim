local status_ok, cscope = pcall(require, "cscope_maps")
if not status_ok then
  vim.notify("cscope fail")
  return
end


local opts = {
  -- maps related defaults
  disable_maps = true, -- "true" disables default keymaps
  skip_input_prompt = false, -- "true" doesn't ask for input
  prefix = "cc", -- prefix to trigger maps

  -- cscope related defaults
  cscope = {
    -- location of cscope db file
    db_file = "./cscope.file",
    -- cscope executable
    exec = "cscope", -- "cscope" or "gtags-cscope"
    -- choose your fav picker
    picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
    -- size of quickfix window
    qf_window_size = 5, -- any positive integer
    -- position of quickfix window
    qf_window_pos = "bottom", -- "bottom", "right", "left" or "top"
    -- "true" does not open picker for single result, just JUMP
    skip_picker_for_single_result = false, -- "false" or "true"
    -- these args are directly passed to "cscope -f <db_file> <args>"
    db_build_cmd_args = { "-Rb" },
    -- statusline indicator, default is cscope executable
    statusline_indicator = nil,
    -- try to locate db_file in parent dir(s)
    project_rooter = {
      enable = false, -- "true" or "false"
      -- change cwd to where db_file is located
      change_cwd = false, -- "true" or "false"
    },
  }
}

cscope.setup(opts)

local maps_ok, maphelp = pcall(require, 'utils.maps_helper')
if not maps_ok then
  vim.notify("cscope_maps.utils fail")
  return
end

function cscopeBuild()
  os.execute([[find ./ -type f -name "*.h" -o -name "*.c" > cscope.file]])
  vim.cmd([[Cscope build]])
end

function cscope_keymaps(prefix)
	local sym_map = maphelp.sym_map
	local ok, wk = pcall(require, "which-key")
  if not ok then
    vim.notify("cscope load which-key fail")
    return;
  end
  wk.register({
    [prefix] = {
      s = {maphelp.get_cscope_prompt_cmd("s", "w"), sym_map.s},
      g = {maphelp.get_cscope_prompt_cmd("g", "w"), sym_map.g},
      c = {maphelp.get_cscope_prompt_cmd("c", "w"), sym_map.c},
      t = {maphelp.get_cscope_prompt_cmd("t", "w"), sym_map.t},
      e = {maphelp.get_cscope_prompt_cmd("e", "w"), sym_map.e},
      f = {maphelp.get_cscope_prompt_cmd("f", "w"), sym_map.f},
      i = {maphelp.get_cscope_prompt_cmd("i", "w"), sym_map.i},
      d = {maphelp.get_cscope_prompt_cmd("d", "w"), sym_map.d},
      a = {maphelp.get_cscope_prompt_cmd("a", "w"), sym_map.a},
      --[[ b = {"<cmd>Cscope build<cr>", sym_map.b}, ]]
      b = {cscopeBuild, sym_map.b}
    }})
end
cscope_keymaps(opts.prefix)

vim.keymap.set("n", "<A-.>", function()
  vim.cmd("Cstag " .. vim.fn.expand("<cword>" .. vim.fn.expand("<cword>")))
end)
vim.keymap.set("n", "<A-,>", "<C-t>")
vim.keymap.set("n", "cg", [[<cmd>exe "Cscope find g" expand("<cword>")<cr>]], { noremap = true, silent = true })

-- see if the file exists
function file_exists(file)
  local f = io.open(file, "r")
  if f then 
    f:close() 
    return true
  end
  return false
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  local lines = {}
  print("line" .. file)
  for line in io.lines(file) do 
    print(line)
    lines[#lines + 1] = line
  end
  return lines
end



--[[ local filePath = vim.fn.expand("%:p:h") .. "/.qoo" ]]
--[[ print(filePath) ]]
--[[ local file_exit = file_exists(filePath) ]]
--[[ if not file_exit then ]]
--[[   print("can't find .qoo file")  ]]
--[[ else  ]]
--[[   print("find .qoo file") ]]
--[[   local opts = lines_from(filePath) ]]
--[[   print(opts[0]) ]]
--[[ end ]]

-- tests the functions above
--[[ local file = 'test.lua' ]]
--[[ local lines = lines_from(file) ]]

-- print all line numbers and their contents
--[[ for k,v in pairs(lines) do ]]
--[[   print('line[' .. k .. ']', v) ]]
--[[ end ]]

--[[ vim.api.nvim_create_user_command("Test", function(input) ]]
--[[   vim.notify(input.path) ]]
--[[ end, { nargs = opts}) ]]
--[[ function testoo(opts) ]]
--[[   vim.notify("test") ]]
--[[   vim.notify(opts.path) ]]
--[[ end ]]
--[[]]


