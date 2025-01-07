local status_ok, projectCfg = pcall(require, 'projectCfg')
if not status_ok then
  vim.notify("projectCfg fail")
  return
end


projectCfg.setup({})
