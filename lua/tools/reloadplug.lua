local status_ok, reload = pcall(require, 'lazy-reload')
if not status_ok then
  vim.notify("reload fail")
  return
end

reload.setup({})
local status_ok, projectCfg = pcall(require, 'projectCfg')
if not status_ok then
  vim.notify("reload fail")
  return
end

projectCfg.setup({})
vim.notify("qqq")
