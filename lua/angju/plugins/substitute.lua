MiniDeps.later(function ()
    MiniDeps.add {
        source = 'gbprod/substitute.nvim',
    }

    local subs = require 'substitute'

    subs.setup {
        on_substitute = function ()
            require('yanky.integration').substitute()
        end,
    }

    local keymaps = {
        { keys = 'so', func = subs.operator, desc = 'Operator [Substitute]' },
        { keys = 'sl', func = subs.line, desc = 'Operator [Substitute]' },
        { keys = 'se', func = subs.eol, desc = 'End of Line [Substitute]' },
        { keys = 'sx', func = subs.visual, desc = 'Visual [Substitute]', mode = 'x' },
        {
            keys = 'sr',
            func = require('substitute.range').operator,
            desc = 'Operator Range [Substitute]',
        },
        {
            keys = 'sX',
            func = require('substitute.range').visual,
            desc = 'Visual Range [Substitute]',
            mode = 'x',
        },
        { keys = 'sw', func = require('substitute.range').word, desc = 'Word Range [Substitute]' },
        {
            keys = 'sR',
            func = require('substitute.exchange').operator,
            desc = 'Exchange Operator [Substitute]',
        },
        {
            keys = 'sL',
            func = require('substitute.exchange').line,
            desc = 'Exchange Line [Substitute]',
        },
        {
            keys = 'sv',
            func = require('substitute.exchange').visual,
            desc = 'Exchange Line [Substitute]',
            mode = 'x',
        },
        {
            keys = 'sq',
            func = require('substitute.exchange').cancel,
            desc = 'Exchange Cancel [Substitute]',
        },
    }

    Angju.multi_set_keymap(keymaps)
end)
