return {
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			vim.g.minisurround_enabled = true
			require("mini.surround").setup({
				mappings = {
					add = "gsa",
					delete = "gsd",
					replace = "gsr",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					update_n_lines = "gsn",
					suffix_last = "gl",
					suffix_next = "gn",
				},
				n_lines = 20,
				search_method = "cover_or_next",
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		version = false,
		config = function()
			vim.g.minipairs_enabled = true
			require("mini.pairs").setup({
				modes = { insert = true, command = true, terminal = false },
				skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
				skip_ts = { "string" },
				skip_unbalanced = true,
				markdown = true,
			})
		end,
	},
}
