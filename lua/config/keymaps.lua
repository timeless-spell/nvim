local keymaps = {
    -- Source
    { keys = "<leader><space>sf", func = "<cmd>source %<cr>", desc = "Source file/buffer" },
    { keys = "<leader><space>sl", func = "<cmd>.lua<cr>", desc = "Source line" },
    { keys = "<leader><space>sc", func = "<cmd>lua<cr>", desc = "Source current chunk", "v" },

    -- Inspect
    { keys = "<leader><space>i", func = "<cmd>Inspect<cr>", desc = "Inspect" },

    -- Navigate buffers
    { keys = "<a-a>", func = "<cmd>bprevious<cr>", desc = "Previous Buffer" },
    { keys = "<a-d>", func = "<cmd>bnext<cr>", desc = "Next Buffer" },

    -- Navigate splits
    { keys = "<c-h>", func = "<c-w><c-h>", desc = "Move focus to the left window " },
    { keys = "<c-l>", func = "<c-w><c-l>", desc = "Move focus to the right window " },
    { keys = "<c-j>", func = "<c-w><c-j>", desc = "Move focus to the lower window " },
    { keys = "<c-k>", func = "<c-w><c-k>", desc = "Move focus to the upper window " },

    -- Clear highlight on search
    { keys = "<esc>", func = "<cmd>nohlsearch<cr>", desc = "Clear highlight" },

    -- Delete current buffer
    { keys = "<a-x>", func = "<cmd>bdelete<cr>", desc = "Delete buffer" },

    -- Modify Split Size
    { keys = "<c-up>", func = "<cmd>resize -2<CR><cr>", desc = "Resize split Up" },
    { keys = "<c-down>", func = "<cmd>resize +2<CR><cr>", desc = "Resize split Down" },
    { keys = "<c-left>", func = "<cmd>vertical resize -2<cr>", desc = "Resize split Left" },
    { keys = "<c-right>", func = "<cmd>vertical resize +2<cr>", desc = "Resize split Right" },
}

Angju.multi_map(keymaps)

vim.keymap.del({ "n", "v" }, "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grn")
