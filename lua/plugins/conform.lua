return {
{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cF",
				function()
					require("conform").format({
						async = true,
						quiet = false,
						lsp_fallback = true,
					})
				end,
				mode = { "n", "v" },
				desc = "Format Buffers",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					async = false,
					quiet = false,
					lsp_format = "fallback",
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettier" },
				css = { "prettier" },
				markdown = { "prettier" },
				sh = { "shfmt" },
				yaml = { "yamlfmt" },
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
