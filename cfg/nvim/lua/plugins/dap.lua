return {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap",
    -- "leoluz/nvim-dap-go",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    { "<leader>db", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
    { "<leader>dc", "<CMD>lua require'dap'.continue()<CR>", desc = "Dap Continue" },
    { "<leader>dx", "<CMD>lua require'dap'.terminate()<CR>", desc = "Dap Terminate" },
    { "<leader>do", "<CMD>lua require'dap'.step_over()<CR>", desc = "Dap Step Over" },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
