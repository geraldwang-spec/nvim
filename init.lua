-- bootstrap lazy.nvim, LazyVim and your plugins
local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/.local/share/nvim/lazy/dkjson/?.lua"
require("config.lazy")
require("utils.config")
