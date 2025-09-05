MiniDeps.later (function ()
  local function build_fff_async (params)
    vim.notify ('Building FFF...', vim.log.levels.INFO)

    vim.system (
      { 'cargo', 'build', '--release' },
      { text = true, cwd = params.path },
      vim.schedule_wrap (function (result)
        if result.code ~= 0 then
          vim.notify ('Building FFF failed \n' .. (result.stderr or result.stdout or ''), vim.log.levels.ERROR)
        else
          vim.notify ('Building FFF completed successfully ✔️', vim.log.levels.INFO)
        end
      end)
    )
  end

  MiniDeps.add ({
    source = 'dmtrKovalenko/fff.nvim',
    hooks = {
      post_install = build_fff_async,
      post_checkout = build_fff_async,
    },
  })

  local fff = require ('fff')
  fff.setup ({
    prompt = ' ',
  })

  local map = Angju.map

  map ('\\ff', function ()
    fff.find_files ()
  end, 'Find files in current directory [FFF].')

  map ('\\fs', function ()
    fff.scan_files ()
  end, 'Rescan of files in current directory [FFF].')

  map ('\\fg', function ()
    fff.find_in_git_root ()
  end, 'Find files in current git repository [FFF].')
end)
