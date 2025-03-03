return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
  },
  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: See last session result.' },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local util = require("lspconfig.util")

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    dap.defaults.kotlin.auto_continue_if_many_stopped = false
    dap.set_log_level('DEBUG')

    dap.adapters.kotlin = {
        type = "executable",
        command = "/Users/robin/code/kotlin/kotlin-debug-adapter/adapter/build/install/adapter/bin/kotlin-debug-adapter",
        options = {
            initialize_timeout_sec = 15,
            disconnect_timeout_sec = 15,
            auto_continue_if_many_stopped = false,
        },
    }

    dap.configurations.kotlin = {
        {
            -- first run g --info cleanTest test --debug-jvm
            -- then attach the debugger to it
            name = "attach debugger",
            type = "kotlin",
            request = "attach",
            hostName = "127.0.0.1",
            port = 5005,
            -- projectRoot = vim.fn.getcwd,
            projectRoot = util.root_pattern("settings.gradle.kts")(vim.fn.fnamemodify(vim.fn.expand("%"), ":p:h")),
            timeout = 20,
        },
        {
            name = "All tests",
            type = "kotlin",
            request = "launch",
            mainClass = "org.junit.platform.console.ConsoleLauncher --scan-class-path",
            projectRoot = util.root_pattern("settings.gradle.kts")(vim.fn.fnamemodify(vim.fn.expand("%"), ":p:h")),
        },
        {
            -- main
            name= "utsjekk.AppKt",
            type = "kotlin",
            request = "launch",
            mainClass = "utsjekk.AppKt",
            projectRoot = util.root_pattern("settings.gradle.kts")(vim.fn.fnamemodify(vim.fn.expand("%"), ":p:h")),
        },
    }
  end,
}
