return {
  "okuuva/auto-save.nvim",
  lazy = false,
  opts = {
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    trigger_events = {
      -- Save and format only after leaving Insert/Replace mode for Normal mode.
      immediate_save = {
        { "ModeChanged", pattern = "[iR]*:n" },
      },
      defer_save = {},
      cancel_deferred_save = {},
    },
    condition = function(buf)
      if vim.fn.getbufvar(buf, "&buftype") ~= "" then
        return false
      end
      return true
    end,
    write_all_buffers = false, -- only save the buffer whose mode changed
    noautocmd = false, -- do not execute autocmds when saving
    lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
    -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
    debug = false,
  },
}
