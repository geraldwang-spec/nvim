local colorscheme = "darkplus"

local status_ok, packer = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme ".. colorscheme .. " not found!")
  return
end



