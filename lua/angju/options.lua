vim.loader.enable ()

local g = vim.g
local o = vim.o
local opt = vim.opt

g.loaded_perl_provider = 0
g.loaded_python3_provider = 0

g.maplocalleader = ' '
g.mapleader = ' '

o.mouse = 'a'
o.mousescroll = 'ver:5,hor:5'
o.undofile = true
o.shada = "'100,<50,s10,:1000,/100,@100,h"
o.updatetime = 250
o.breakindent = true
o.cursorline = true
o.number = true
o.numberwidth = 5
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
opt.listchars = { eol = '󱞥', tab = ' ' }
o.autoindent = true
o.expandtab = true
o.ignorecase = true
o.incsearch = true
o.infercase = true
o.shiftwidth = 4
o.smartcase = true
o.smartindent = true
o.spelloptions = 'camel'
o.tabstop = 4
o.virtualedit = 'block'
