return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = 'light',
        percentage = 0.25, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = {}, -- Change the style of comments
        conditionals = {},
        loops = {},
        functions = { 'bold' },
        keywords = { 'bold' },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = { 'italic' },
      },
      color_overrides = {
        mocha = {
          peach = '#AF9CFF',
          teal = '#BBC3FF',
          sky = '#FFB1E7',
          blue = '#B793ED',
          lavender = '#F5C8FF',
          green = '#C1F98F',
          text = '#F4CDE9',
          subtext1 = '#DEBAD4',
          subtext0 = '#C8A6BE',
          overlay2 = '#B293A8',
          overlay1 = '#9C7F92',
          overlay0 = '#866C7D',
          surface2 = '#705867',
          surface1 = '#5A4551',
          surface0 = '#44313B',

          base = '#352939',
          mantle = '#211924',
          crust = '#1a1016',
        },
      },
      custom_highlights = {},
      integrations = {
        cmp = true,
        neotree = true,
        treesitter = true,
        notify = true,
        barbecue = {
          dim_dirname = true, -- directory name is dimmed by default
          bold_basename = true,
          dim_context = true,
          alt_background = false,
        },
        fidget = true,
        gitsigns = true,
        indent_blankline = {
          enabled = true,
          scope_color = 'rosewater', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        telescope = {
          enabled = true,
        },
        which_key = true,
        mason = true,
        treesitter_context = true,

        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme('catppuccin')
  end,
}
