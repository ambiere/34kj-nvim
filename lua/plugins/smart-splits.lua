return {
	{
		"mrjones2014/smart-splits.nvim",
		opts = {
			ignored_buftypes = { "nofile", "quickfix", "prompt" },
			ignored_filetypes = { "NvimTree" },
			default_amount = 3, -- Resize amount
			multiplexer_integration = nil, -- Auto-detect tmux/Kitty
		},
		keys = {},
	},
}
