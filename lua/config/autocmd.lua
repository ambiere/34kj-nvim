local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
local whitespace_group = vim.api.nvim_create_augroup("WhitespaceAutogroup", {})
local semicolon_group = vim.api.nvim_create_augroup("SemicolonAutogroup", {})

-- remove whitespace at the end of the line
-- before buffer has been written
vim.api.nvim_create_autocmd("BufWritePre", {
	group = whitespace_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- remove semicolon in js/tsx
-- before buffer has been written
vim.api.nvim_create_autocmd("BufWritePost", {
	group = semicolon_group,
	pattern = "*.{js,jsx}",
	command = [[%s/;$//e]],
})

-- highlight the yanked text for n-time
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})
