return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dapui = require("dapui")
		local dap = require("dap")

		dapui.setup()

		-- Typescript/Javascript adapter
		dap.adapters["pwa-node"] = {
			type = "executable",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "js-debug-adapter",
			},
		}

		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				runtimeExecutable = "deno",
				runtimeArgs = {
					"run",
					"--inspect-wait",
					"--allow-all",
				},
				program = "${file}",
				cwd = "${workspaceFolder}",
				attachSimplePort = 9229,
			},
		}

		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}

		require("mason-nvim-dap").setup({
			handlers = {}, -- sets up dap in the predefined manner
		})

		vim.keymap.set("n", "<F5>", dap.continue, { desc = "[F1] Continue" })
		vim.keymap.set("n", "<F6>", dap.step_over, { desc = "[F2] Step Over" })
		vim.keymap.set("n", "<F7>", dap.step_into, { desc = "[F3] Step Into" })
		vim.keymap.set("n", "<F8>", dap.step_out, { desc = "[F4] Step Out" })
		vim.keymap.set("n", "<leader>tB", dap.toggle_breakpoint, { desc = "[T]oggle [B]reakpoint" })
		vim.keymap.set("n", "<leader>B", dap.set_breakpoint, { desc = "[B]reakpoint" })
		-- vim.keymap.set("n", "<Leader>lp", dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")))
		-- vim.keymap.set("n", "<leader>dr", dap.repl.open)
		-- vim.keymap.set("n", "<leader>dl", dap.run_last)
		-- vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover())
		-- vim.keymap.set({ "n", "v" }, "<Leader>dp", require("dap.ui.widgets").preview())
		-- vim.keymap.set("n", "<leader>df", function()
		-- local widgets = require("dap.ui.widgets")
		-- 	widgets.centered_float(widgets.frames)
		-- end)
		-- vim.keymap.set("n", "<leader>ds", function()
		-- 	local widgets = require("dap.ui.widgets")
		-- 	widgets.centered_float(widgets.scopes)
		-- end)
		vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "[D]ap UI [E]val" })
		vim.keymap.set("n", "<leader>do", dapui.open, { desc = "[D]ap UI [O]pen" })
		vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ap UI [C]lose" })
		vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "[D]ap UI [T]oggle" })
		vim.keymap.set("n", "<leader>df", dapui.float_element, { desc = "[D]ap UI [F]loat Element" })
	end,
}
