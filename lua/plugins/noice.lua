return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					opts = {
						border = "single",
						win_options = {
							winhighlight = {
								Normal = "NormalFloat",
								FloatBorder = "LineNr",
							},
						},
					},
				},
				hover = {
					enabled = true,
					opts = {
						border = {
							style = "single",
							padding = { 0, 1 },
						},

						win_options = {
							winhighlight = {
								Normal = "NormalFloat",
								FloatBorder = "LineNr",
							},
						},
					},
				},
			},
			notify = { enabled = false },
			popupmenu = { enabled = false },
			messages = { enabled = false },
			cmdline = { enabled = false },
		},
		dependencies = { "MunifTanjim/nui.nvim" },
	},
}
