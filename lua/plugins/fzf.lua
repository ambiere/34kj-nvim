return {
	{
		"ibhagwan/fzf-lua",
		opts = {
			winopts = {
				border = "none",
				preview = {
					border = "none",
					hidden = true,
				},
			},

			fzf_colors = {
				true,
				["pointer"] = { "fg", "Function" },
				["spinner"] = { "fg", "Function" },
			},
			files = {
				cwd_prompt = false,
			},
			grep = {
				file_icons = false,
				color_icons = false,
				no_header = true,
			},
		},
	},
}
