MiniDeps.later(function ()
    MiniDeps.add {
        source = 'dmtrKovalenko/fff.nvim',
    }

    local fff = require 'fff'

    fff.setup {
        prompt = ' ',
        layout = {
            preview_size = 0.6,
            show_scrollbar = false,
        },
    }

    local keymaps = {
        {
            keys = '\\ff',
            func = function ()
                fff.find_files()
            end,
            desc = 'Find files in current directory [FFF].',
        },
        {
            keys = '\\fg',
            func = function ()
                fff.find_in_git_root()
            end,
            desc = 'Find files in current git repository [FFF].',
        },
        {
            keys = '\\fs',
            func = function ()
                fff.scan_files()
            end,
            desc = 'Rescan of files in current directory [FFF].',
        },
        {
            keys = '\\fr',
            func = function ()
                fff.find_in_git_root()
            end,
            desc = 'Refresh git status for the active file lock [FFF].',
        },
        {
            keys = '\\fN',
            func = function ()
                local dir = vim.fn.stdpath 'config'
                fff.find_files_in_dir(dir)
            end,
            desc = 'Find files in Neovim config dir [FFF].',
        },
    }

    Angju.multi_set_keymap(keymaps)
end)
