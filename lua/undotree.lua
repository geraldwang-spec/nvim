--local status_ok, config = pcall(require, "undotree")
--if not status_ok then
--  vim.notify("undotree fail")
--  return
--end

vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle)
