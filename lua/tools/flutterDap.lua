local status_ok, flutter = pcall(require, "flutter-tools")
if not status_ok then
  vim.notify('flutter tools fail')
  return
end

flutter.setup({
  debugger = {
      enabled = true,
      run_via_dap = true,
      exception_breakpoints = {},
      register_configurations = function(paths)
          local dap = require("dap")
          -- See also: https://github.com/akinsho/flutter-tools.nvim/pull/292
          dap.adapters.dart = {
              type = "executable",
              command = paths.flutter_bin,
              args = { "debug-adapter" },
          }
          dap.configurations.dart = {}
          require("dap.ext.vscode").load_launchjs()
      end,
  },
})

require("mason-nvim-dap").setup({
  ensure_install = {"dart"},
  automatic_installation = true,
  handler = {}
})
