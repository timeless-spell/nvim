MiniDeps.later (function ()
  MiniDeps.add ({
    source = 'lewis6991/gitsigns.nvim',
  })

  local gitsigns = require ('gitsigns')

  gitsigns.setup ({
    signs = {
      add = { text = '' },
      change = { text = '' },
      delete = { text = '' },
      topdelete = { text = '󰆴' },
      changedelete = { text = '↩️' },
    },
    on_attach = function (bufnr)
      local function map (mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set (mode, l, r, opts)
      end

      -- Navigation
      map ('n', ']c', function ()
        if vim.wo.diff then
          vim.cmd.normal ({ ']c', bang = true })
        else
          gitsigns.nav_hunk ('next')
        end
      end, { desc = 'Jump to next git [c]hange' })

      map ('n', '[c', function ()
        if vim.wo.diff then
          vim.cmd.normal ({ '[c', bang = true })
        else
          gitsigns.nav_hunk ('prev')
        end
      end, { desc = 'Jump to previous git [c]hange' })

      -- [ Actions ]

      -- Visual mode
      map ('v', '<leader>gs', function ()
        gitsigns.stage_hunk ({ vim.fn.line ('.'), vim.fn.line ('v') })
      end, { desc = 'Stage git hunk' })
      map ('v', '<leader>gr', function ()
        gitsigns.reset_hunk ({ vim.fn.line ('.'), vim.fn.line ('v') })
      end, { desc = 'Git [s]tage hunk' })

      -- Normal mode
      map ('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Git [s]tage hunk' })
      map ('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Git [r]eset hunk' })
      map ('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Git [S]tage buffer' })
      map ('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Git [R]eset buffer' })
      map ('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Git [p]review hunk' })
      map ('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Git [u]ndo stage hunk' })
      map ('n', '<leader>gb', gitsigns.blame_line, { desc = 'Git [b]lame line' })
      map ('n', '<leader>gd', gitsigns.diffthis, { desc = 'Git [d]iff against index' })
      map ('n', '<leader>gD', function ()
        gitsigns.diffthis ('@')
      end, { desc = 'git [D]iff against last commit' })
      map ('n', '<leader>gQ', gitsigns.setqflist ('all'), { desc = 'Git open [q]uickfix' })
      map ('n', '<leader>gq', gitsigns.setqflist, { desc = 'Git open [q]uickfix' })
      -- Toggles
      map ('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = 'Toggle [g]it show [b]lame line' })
      map ('n', '<leader>gtD', gitsigns.toggle_deleted, { desc = 'Toggle [g]it show [D]eleted' })

      map ({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Hunk Text Object' })
    end,
  })
end)
