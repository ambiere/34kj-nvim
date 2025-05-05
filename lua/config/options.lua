vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.numberwidth = 4
vim.opt.wrap = false
vim.opt.smoothscroll = true
vim.opt.sidescroll = 5
vim.opt.sidescrolloff = 8
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.nvim/undo")
vim.fn.mkdir(vim.fn.expand("~/.nvim/undo"), "p")
vim.opt.undolevels = 10000
vim.opt.undoreload = 10000
vim.opt.swapfile = false
vim.opt.updatetime = 500
vim.opt.hlsearch = false
vim.opt.cmdheight = 0
vim.opt.fillchars = { eob = " " }
