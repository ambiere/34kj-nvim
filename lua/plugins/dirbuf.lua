return {
	{
		"elihunter173/dirbuf.nvim",
		config = function()
			require("dirbuf").setup({
				write_cmd = "DirbufSync -confirm",
			})
		end,
	},
}
