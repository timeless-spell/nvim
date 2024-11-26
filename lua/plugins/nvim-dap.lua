return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
	},
	keys = {
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<leader>dtb",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "Debug: Set Breakpoint",
		},
	},
	config = function(_, opts)
		local dap, dapui = require("dap"), require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true,

			handlers = {},

			ensure_installed = {
				-- "delve",
			},
		})

		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		local map = vim.keymap.set

		map("n", "<leader>dsi", function()
			require("dap").step_into()
		end, { desc = "Debug: Step Into" })

		map("n", "<leader>dsv", function()
			require("dap").step_over()
		end, { desc = "Debug: Step Over" })

		map("n", "<leader>dsu", function()
			require("dap").step_out()
		end, { desc = "Debug: Step Out" })

		map("n", "<leader>dls", function()
			require("dapui").toggle()
		end, { desc = "Debug: See last session result." })

		vim.api.nvim_create_user_command("DAPUIopen", function()
			dapui.open()
		end, {})

		vim.api.nvim_create_user_command("DAPUIclose", function()
			dapui.close()
		end, {})

		vim.api.nvim_create_user_command("DAPUItoggle", function()
			dapui.toggle()
		end, {})

		vim.api.nvim_create_user_command("DAPUIfloat", function()
			dapui.float_element()
		end, {})

		vim.api.nvim_create_user_command("DAPUIeval", function()
			dapui.eval()
		end, {})
	end,
}
