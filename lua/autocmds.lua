require "nvchad.autocmds"

-- Noctalia v5 -> base46 live reload
-- noctalia's nvim-base46 template sends SIGUSR1 on regeneration (post_hook);
-- an fs watcher on the rendered palette file is the fallback in case the
-- signal is missed.

-- only run while the active base46 theme is the noctalia palette
local function is_noctalia_active()
  local ok, base46 = pcall(require, "nvconfig")
  local theme = ok and base46.base46 and base46.base46.theme
  return theme == "noctalia-palette"
end

local function reload_noctalia()
  if not is_noctalia_active() then return end
  package.loaded["themes.noctalia-palette"] = nil
  pcall(function() require("base46").load_all_highlights() end)
end

local function notify_source()
  if not is_noctalia_active() then return end
  vim.schedule(function()
    local ok, t = pcall(require, "themes.noctalia-palette")
    if not ok then
      vim.notify("noctalia base46: palette not found", vim.log.levels.WARN)
      return
    end
    local b = t.base_30 or {}
    vim.notify(
      ("noctalia base46 reloaded: type=%s | black=%s | primary(purple)=%s"):format(
        t.type, b.black, b.purple
      ),
      vim.log.levels.INFO
    )
  end)
end

vim.api.nvim_create_user_command("NoctaliaReload", function()
  if not is_noctalia_active() then
    vim.notify("Noctalia palette is not the active theme", vim.log.levels.WARN)
    return
  end
  reload_noctalia()
  notify_source()
end, { desc = "Recompile base46 from Noctalia palette" })

-- respond to noctalia's SIGUSR1 post_hook
if is_noctalia_active() then
  local signal = vim.uv.new_signal()
  if signal then
    signal:start("sigusr1", vim.schedule_wrap(function()
      reload_noctalia()
      notify_source()
    end))
  end

  -- backup: fs watch the rendered palette dir (debounced) in case signal is missed
  local palette_dir = vim.fn.stdpath "config" .. "/lua/themes"
  local timer
  local fs = vim.uv.new_fs_event()
  if fs then
    fs:start(palette_dir, {}, vim.schedule_wrap(function(_err, fname)
      if fname and fname:match "noctalia%-palette" then
        if timer then timer:stop() end
        timer = vim.uv.new_timer()
        timer:start(200, 0, vim.schedule_wrap(function()
          timer:stop()
          reload_noctalia()
          notify_source()
        end))
      end
    end))
  end
end
