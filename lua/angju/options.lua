-- Globals
local g = vim.g
g.mapleader = ' '
g.maplocalleader = ' '

g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

-- General
local o = vim.o
local opt = vim.opt

o.mouse = 'a'
o.mousescroll = 'ver:25,hor:6'
o.undofile = true
o.shada = "'100,<50,s10,:1000,/100,@100,h"
o.updatetime = 250

-- UI
o.breakindent = true
o.cursorline = true
o.number = true
o.relativenumber = true
o.ruler = false
o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.inccommand = 'split'
o.backup = false
o.showmode = false
o.scrolloff = 5
o.wrap = false
o.termguicolors = true

o.list = true
opt.listchars = { eol = '󱞥', tab = '| ' }

-- Editing
o.autoread = true
o.autoindent = true
o.expandtab = true
o.ignorecase = true
o.incsearch = true
o.infercase = true
o.shiftwidth = 2
o.smartcase = true
o.smartindent = true
o.spelloptions = 'camel'
o.tabstop = 2
o.virtualedit = 'block'
