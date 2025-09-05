MiniDeps.now (function ()
  MiniDeps.add ({
    source = 'rcarriga/nvim-notify',
    -- depends = {
    --   'j-hui/fidget.nvim',
    -- },
  })

  local notify = require ('notify')

  notify.setup ({
    stager = 'fade',
    timeout = 2000,
  })

  vim.notify = notify

  local client_notifs = {}

  local function get_notif_data (client_id, token)
    client_notifs[client_id] = client_notifs[client_id] or {}
    client_notifs[client_id][token] = client_notifs[client_id][token] or {}
    return client_notifs[client_id][token]
  end

  -- local spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' }
  local spinner_frames = { '▏', '▎', '▍', '▌', '▋', '▊', '▉', '▊', '▋', '▌', '▍', '▎' }
  local function update_spinner (client_id, token)
    local notif_data = get_notif_data (client_id, token)

    if not notif_data.spinner then
      return
    end

    local new_spinner = (notif_data.spinner + 1) % #spinner_frames
    notif_data.spinner = new_spinner

    notif_data.notification = vim.notify (nil, nil, {
      hide_from_history = true,
      icon = spinner_frames[new_spinner],
      replace = notif_data.notification,
    })

    vim.defer_fn (function ()
      update_spinner (client_id, token)
    end, 100)
  end

  local function format_title (title, client_name)
    return client_name .. (title and #title > 0 and ': ' .. title or '')
  end

  local function format_message (message, percentage)
    return (percentage and percentage .. '%\t' or '') .. (message or '')
  end

  local function clear_notif_data (client_id, token)
    if client_notifs[client_id] then
      client_notifs[client_id][token] = nil
      if next (client_notifs[client_id]) == nil then
        client_notifs[client_id] = nil
      end
    end
  end

  vim.lsp.handlers['$/progress'] = function (_, result, ctx)
    local client_id = ctx.client_id
    local client = vim.lsp.get_client_by_id (client_id)
    if not client then
      return
    end

    local val = result.value
    if not val.kind then
      return
    end

    local notif_data = get_notif_data (client_id, result.token)

    if val.kind == 'begin' then
      local message = format_message (val.message, val.percentage)
      local title = format_title (val.title, client.name)

      notif_data.notification = vim.notify (message, 'info', {
        title = title,
        icon = spinner_frames[1],
        timeout = false,
        hide_from_history = false,
      })

      notif_data.spinner = 1
      update_spinner (client_id, result.token)
    elseif val.kind == 'report' and notif_data then
      notif_data.notification = vim.notify (format_message (val.message, val.percentage), 'info', {
        replace = notif_data.notification,
        hide_from_history = false,
      })
    elseif val.kind == 'end' and notif_data then
      local message = val.message and format_message (val.message) or 'Complete'
      notif_data.notification = vim.notify (message, 'info', {
        icon = '',
        replace = notif_data.notification,
        timeout = 3000,
      })

      -- Clean up data and stop spinner
      notif_data.spinner = nil
      clear_notif_data (client_id, result.token)
    end
  end

  local severity_levels = {
    [1] = 'error',
    [2] = 'warn',
    [3] = 'info',
    [4] = 'info',
  }

  vim.lsp.handlers['window/showMessage'] = function (_, method, params, client_id)
    local severity = severity_levels[params.type] or 'info'
    vim.notify (method.message, severity)
  end
end)
