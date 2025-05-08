local function break_line()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local indent = line:match("^%s*")
	local left = line:sub(1, col)
	local right = line:sub(col + 1)
	vim.api.nvim_buf_set_lines(
		0,
		vim.api.nvim_win_get_cursor(0)[1] - 1,
		vim.api.nvim_win_get_cursor(0)[1],
		false,
		{ left, indent .. right }
	)
	vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1] + 1, #indent })
end

local function join_lines()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	if row < vim.api.nvim_buf_line_count(0) then
		vim.api.nvim_buf_set_lines(0, row - 1, row + 1, false, {
			vim.api.nvim_get_current_line() .. " " .. vim.api
				.nvim_buf_get_lines(0, row, row + 1, false)[1]
				:match("^%s*(.-)%s*$"),
		})
		vim.api.nvim_win_set_cursor(0, { row, #vim.api.nvim_get_current_line() })
	end
end

local function format_buffer()
	require("conform").format({ async = true, lsp_fallback = true })
end

require("which-key").add({
	{ "<leader>eb", break_line, desc = "Break Line", mode = "n" },
	{ "<leader>ej", join_lines, desc = "Join Lines", mode = "n" },
	{ "<leader>cf", format_buffer, desc = "Format Buffer", mode = "n" },
	{ "<leader>ff", "<cmd>Fz files<cr>", desc = "Find Files", mode = "n" },
	{ "<leader>fg", "<cmd>Fz live_grep<cr>", desc = "Live Grep", mode = "n" },
	-- { "<leader>-", "<Cmd>Oil<CR>", desc = "Open parent directory", mode = "n" },
	{ "<S-k>", ":m'<-2<CR>gv", mode = { "n", "v" }, { noremap = true, silent = true } },
	{ "<S-j>", ":m'>+1<CR>gv", { mode = { "n", "v" }, noremap = true, silent = true } },
	{ "<Leader>bd", "<Cmd>bdelete<CR>", desc = "Delete Buffer", noremap = true, silent = true, mode = "n" },
	{ "<S-h>", "<Cmd>bprevious<CR>", desc = "Previous Buffer", noremap = true, silent = true, mode = "n" },
	{ "<S-l>", "<Cmd>bnext<CR>", desc = "Next Buffer", noremap = true, silent = true, mode = "n" },
	{ "q", "<Nop>", noremap = true, silent = true, desc = "Disabled", mode = "n" },
	{ "<leader>G", "<cmd>silent !lazy-dawg<cr>", desc = "lazygit cwd", mode = "n" },
	{ "<leader><leader>", "mm:w<cr>'m:delm m<cr>", desc = "Save and enter normal mode", mode = "n" },
	{ "<C-s>", "<Esc>mm:w<cr>'m:delm m<cr>", desc = "Trigger save and return keymap", mode = "i" },
	{ "<leader>p", "<cmd>YankyRingHistory<cr>", mode = { "n", "x", "v" }, desc = "Open Yank History" },
	{ "<leader>y", "<Plug>(YankyYank)", mode = { "n", "x", "v" }, desc = "Yank text" },
	{
		"<leader>p",
		"<Plug>(YankyPutAfterder><leader>)",
		mode = { "n", "x", "v" },
		desc = "Put yanked text after cursor",
	},
	{ "<leader>P", "<Plug>(YankyPutBefore)", mode = { "n", "x", "v" }, desc = "Put yanked text before cursor" },
	{ "<leader>nt", "<CMD>set number! relativenumber!<CR>", desc = "Toggle Line Numbers", mode = "n" },
	{ "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
	{ "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
	{ "<leader>]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
	{ "<leader>[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
	{ "<leader>]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
	{ "<leader>[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
	{ "<leader>>p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
	{ "<leader><p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
	{ "<leader>>P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
	{ "<leader><P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
	{ "<leader>=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
	{ "<leader>=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
	{ "<leader>Y", [["+Y]], mode = { "n", "x", "v" }, desc = "Yank text to register" },
	{ "<leader>dd", [["_d]], mode = { "n", "x", "v" }, desc = "Delete without register" },
	{
		"<leader>sa",
		function()
			vim.fn.feedkeys(" sa", "n")
		end,
		desc = "Add Surrounding",
		mode = { "n", "v" },
		group = "Surround",
	},
	{
		"<leader>sd",
		function()
			vim.fn.feedkeys(" sd", "n")
		end,
		desc = "Delete Surrounding",
		mode = "n",
		group = "Surround",
	},
	{
		"<leader>sr",
		function()
			vim.fn.feedkeys(" sr", "n")
		end,
		desc = "Replace Surrounding",
		mode = "n",
		group = "Surround",
	},
	{
		"<leader>sf",
		function()
			vim.fn.feedkeys(" sf", "n")
		end,
		desc = "Find Surrounding",
		mode = "n",
		group = "Surround",
	},
	{
		"<leader>gp",
		"<Plug>(YankyGPutAfter)",
		mode = { "n", "x", "v" },
		desc = "Put yanked text after selection",
	},
	{
		"<leader>gP",
		"<Plug>(YankyGPutBefore)",
		mode = { "n", "x", "v" },
		desc = "Put yanked text before selection",
	},
	{
		"<leader>PP",
		[["_dP]],
		mode = { "n", "x", "v" },
		desc = "Put yanked text from register after cursor, over and over again",
	},
	{
		"<C-h>",
		function()
			require("smart-splits").move_cursor_left()
		end,
		desc = "Move to Left Split",
	},
	{
		"<C-j>",
		function()
			require("smart-splits").move_cursor_down()
		end,
		desc = "Move to Down Split",
	},
	{
		"<C-k>",
		function()
			require("smart-splits").move_cursor_up()
		end,
		desc = "Move to Up Split",
	},
	{
		"<C-l>",
		function()
			require("smart-splits").move_cursor_right()
		end,
		desc = "Move to Right Split",
	},
})
