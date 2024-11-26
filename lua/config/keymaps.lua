local map = vim.keymap.set
local dmap = vim.keymap.del

-- Close current buffer
map("n", "<a-d>", "<CMD>bdelete<CR>", { desc = "Close current bdeletebuffer" })
-- Close current window
map("n", "<a-q>", "<CMD>q<CR>", { desc = "Close current window" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<CMD>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Naviagate buffers
map("n", "<a-left>", "<CMD>bnext<cr>", { noremap = true, silent = true, desc = "Navigate next buffer" })
map("n", "<a-right>", "<CMD>bprevious<cr>", { noremap = true, silent = true, desc = "Navigate previous buffer" })

-- Modify Split Size
map("n", "<c-up>", "<CMD>resize -2<CR><cr>", { noremap = true, silent = true, desc = "Resize split Up" })
map("n", "<c-down>", "<CMD>resize +2<CR><cr>", { noremap = true, silent = true, desc = "Resize split Down" })
map("n", "<c-left>", "<CMD>vertical resize -2<cr>", { noremap = true, silent = true, desc = "Resize split Left" })
map("n", "<c-right>", "<CMD>vertical resize +2<cr>", { noremap = true, silent = true, desc = "Resize split Right" })

-- Deleted default keymaps to avoid duplicates
dmap({ "n", "x" }, "gra")
dmap("n", "grr")
dmap("n", "grn")
dmap("i", "<c-s>")
dmap("n", "gri")
