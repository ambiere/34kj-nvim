local cmp = require("cmp")
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

cmp.setup({
	window = {
		completion = cmp.config.window.bordered({
			border = "single",
			winhighlight = "",
			col_offset = 0,
			side_padding = 1,
			scrollbar = false,
		}),

		documentation = cmp.config.window.bordered({
			border = "single",
			winhighlight = "",
			col_offset = 0,
			side_padding = 1,
			scrollbar = false,
		}),
	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				path = "[Path]",
				vsnip = "[Snippet]",
			})[entry.source.name]
			return vim_item
		end,
	},

	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "vsnip" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	matching = { disallow_symbol_nonprefix_matching = false },
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "ts_ls" },
	automatic_installation = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "cmp_nvim_lsp") then
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

local on_attach = function(client, bufnr, bufrid)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufrid,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = bufrid,
			callback = vim.lsp.buf.clear_references,
		})
	end

	local bufopts = { buffer = bufnr, desc = "LSP: " }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "Go to Definition" }))
	vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "Find References" }))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Hover Documentation" }))
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "Rename Symbol" }))
	vim.keymap.set(
		"n",
		"<leader>ca",
		vim.lsp.buf.code_action,
		vim.tbl_extend("force", bufopts, { desc = "Code Action" })
	)
	vim.keymap.set(
		"n",
		"<leader>fd",
		vim.lsp.buf.format,
		vim.tbl_extend("force", bufopts, { desc = "Format Document" })
	)
	vim.keymap.set(
		"n",
		"<leader>ds",
		vim.diagnostic.open_float,
		vim.tbl_extend("force", bufopts, { desc = "Show Diagnostics" })
	)
	vim.keymap.set(
		"n",
		"[d",
		vim.diagnostic.goto_prev,
		vim.tbl_extend("force", bufopts, { desc = "Previous Diagnostic" })
	)
	vim.keymap.set(
		{ "n", "v" },
		"]d",
		vim.diagnostic.goto_next,
		vim.tbl_extend("force", bufopts, { desc = "Next Diagnostic" })
	)
	vim.keymap.set({ "n", "v" }, "<S-k>", ":m'<-2<CR>gv", { noremap = true, silent = true })
	vim.keymap.set({ "n", "v" }, "<S-j>", ":m'>+1<CR>gv", { noremap = true, silent = true })
end

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,

	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
})

lspconfig.tailwindcss.setup({
	filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	settings = {
		tailwindCSS = {
			classAttributes = {
				"class",
				"className",
				"styles",
				"style",
			},
		},
	},
})

vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.HINT] = "H",
			[vim.diagnostic.severity.INFO] = "I",
		},
	},
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "single",
		padding = { 0, 1 },
	},
	virtual_lines = false,
	underline = true,
})
