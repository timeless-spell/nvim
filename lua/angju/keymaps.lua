---@type angju.Keymap[]
local keymaps = {
    -- Source files
    { keys = '<Leader><Space>sf', func = '<CMD>source %<CR>', desc = 'Source file/buffer' },
    { keys = '<Leader><Space>sl', func = '<CMD>.lua<CR>', desc = 'Source line' },
    {
        keys = '<Leader><Space>sc',
        func = '<CMD>lua<CR>',
        desc = 'Source current chunk',
        mode = 'x',
    },

    -- Inspect
    { keys = '<Leader><Space>i', func = '<CMD>Inspect<CR>', desc = 'Inspect' },

    -- Navigate buffers
    { keys = '<A-a>', func = '<CMD>bprevious<CR>', desc = 'Previous Buffer' },
    { keys = '<A-d>', func = '<CMD>bnext<CR>', desc = 'Next Buffer' },

    -- Delete current buffer
    { keys = '<a-x>', func = '<cmd>bdelete<cr>', desc = 'Delete buffer' },

    -- Navigate splits
    { keys = '<C-h>', func = '<C-w><C-h>', desc = 'Move focus to the left window ' },
    { keys = '<C-l>', func = '<C-w><C-l>', desc = 'Move focus to the right window ' },
    { keys = '<C-j>', func = '<C-w><C-j>', desc = 'Move focus to the lower window ' },
    { keys = '<C-k>', func = '<C-w><C-k>', desc = 'Move focus to the upper window ' },

    -- Clear highlight on search
    { keys = '<esc>', func = '<CMD>nohlsearch<CR>', desc = 'Clear highlight' },

    -- Modify Split Size
    { keys = '<C-up>', func = '<CMD>resize -2<CR><CR>', desc = 'Resize split Up' },
    { keys = '<C-down>', func = '<CMD>resize +2<CR><CR>', desc = 'Resize split Down' },
    { keys = '<C-left>', func = '<CMD>vertical resize -2<CR>', desc = 'Resize split Left' },
    { keys = '<C-right>', func = '<CMD>vertical resize +2<CR>', desc = 'Resize split Right' },
}

local unmap = {
    { mode = { 'n', 'v' }, keys = 'gra' },
    { mode = 'n', keys = 'grr' },
    { mode = 'n', keys = 'grt' },
    { mode = 'n', keys = 'gri' },
    { mode = 'n', keys = 'grn' },
}

Angju.multi_set_keymap(keymaps)
Angju.del_keymap(unmap)
