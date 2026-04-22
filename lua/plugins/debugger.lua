return {
    {
      "mfussenegger/nvim-dap",
      lazy = true,
      keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "DAP: Toggle breakpoint" },
			{ "<leader>dc", "<cmd>DapContinue<CR>", desc = "DAP: Continue/start" },
			{ "<leader>dq", "<cmd>DapTerminate<CR>", desc = "DAP: terminate" },
			{ "<leader>du", "<cmd>lua require('dap').up()<CR>", desc = "DAP: Go up in call stack" },
			{ "<leader>dd", "<cmd>lua require('dap').down()<CR>", desc = "DAP: Go down in call stack" },
			{ "<leader>dx", "<cmd>lua require('dapui').toggle()<CR>", desc = "DAP: Toggle ui" },
			{ '<leader>do', "<cmd>DapStepOver<CR>", desc = "DAP: step over" },
			{ '<leader>di', "<cmd>DapStepInto<CR>", desc = "DAP: step into" },
			{ '<leader>dO', "<cmd>DapStepOut<CR>", desc = "DAP: step out" },
            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            -- { "<F7>", function() require("dapui").toggle() end, desc = "Debug: See last session result." },
      },
		config = function ()
			local dap = require("dap")
			local dapui = require("dapui")

			dap.set_log_level("TRACE")

            dap.listeners.after.event_stopped.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			-- Start DAPUI when needed, and enable mouse
			-- dap.listeners.before.launch.dapui_config = function()
				-- vim.opt.splitright = false
				-- vim.opt.splitbelow = false
				-- vim.o.mouse = "a"
			-- 	dapui.open()
			-- end
			-- Close DAPUI and disable mouse
			-- dap.listeners.before.event_terminated.dapui_config = function()
				-- vim.opt.splitright = true
				-- vim.opt.splitbelow = true
				-- vim.o.mouse = ""
			-- 	dapui.close()
			-- end

			-- Load all debug adapters in '/lua/plugins/adapters'
			local dap_adapters_dir = vim.fn.stdpath('config') .. '/lua/plugins/adapters/'
			for _, file in ipairs(vim.fn.readdir(dap_adapters_dir)) do
				local adapter_path = dap_adapters_dir .. file
				if adapter_path:match('%.lua$') then
					dofile(adapter_path)
				end
			end

		end
	},
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
        },
        lazy = true,
		opts = {
			expand_lines = false,
			layouts = {
				{
					elements = { "console", "watches", "scopes" },
					size = 0.3,
					position = "right"
				},
				{
					elements = { "repl", "stacks" },
					size = 0.3,
					position = "bottom",
				},
			},
			floating = { border = "rounded" },
		}
    },
	-- {
	-- 	"MunifTanjim/nui.nvim",
	-- 	lazy = true,
	-- }
}
