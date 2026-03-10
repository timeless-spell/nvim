-- General ====================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.mouse = 'a'
vim.o.mousescroll = 'ver:25,hor:6'
vim.o.undofile = true
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"
vim.o.updatetime = 250

-- UI =========================================================================
vim.o.breakindent = true
vim.o.colorcolumn = '+1'
vim.o.cursorline = true
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.inccommand = 'split'
vim.o.backup = false
vim.o.showmode = false
vim.o.scrolloff = 5
vim.o.wrap = false
vim.o.termguicolors = true

vim.opt.listchars = { eol = '󱞥', tab = '| ' }

-- Editing ====================================================================
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.formatoptions = 'rqnl1j'
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelloptions = 'camel'
vim.o.tabstop = 2
vim.o.virtualedit = 'block'

-- Disable ====================================================================
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
