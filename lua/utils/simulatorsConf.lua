local status_ok, simulators = pcall(require, "simulators")
if not status_ok then
  vim.notify("simulators fail")
  return
end

simulators.setup({
  android_emulator = true,
  apple_emulator = false,
})

require("telescope").load_extension("simulators")
