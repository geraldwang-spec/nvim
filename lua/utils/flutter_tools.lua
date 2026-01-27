local status_ok, flutter = pcall(require, "flutter-tools")
if not status_ok then
  return
end

flutter.setup({})
vim.keymap.set("n", "Ft", "<cmd>FlutterOutlineToggle<CR>")
vim.keymap.set("n", "Fd", "<cmd>FlutterDevices<CR>")
vim.keymap.set("n", "Fe", "<cmd>FlutterEmulators<CR>")
vim.keymap.set("n", "Fl", "<cmd>FlutterLogToggle<CR>")
vim.keymap.set("n", "Fc", "<cmd>FlutterLogClear<CR>")
vim.keymap.set("n", "Frr", "<cmd>FlutterReload<CR>")
vim.keymap.set("n", "FR", "<cmd>FlutterRestart<CR>")
vim.keymap.set("n", "Fr", "<cmd>FlutterRun<CR>")
vim.keymap.set("n", "Fq", "<cmd>FlutterQuit<CR>")
