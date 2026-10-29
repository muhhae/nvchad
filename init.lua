vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    repo,
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
if not vim.uv.fs_stat(vim.g.base46_cache .. "defaults") then
  require("base46").load_all_highlights()
end

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.api.nvim_create_user_command("LspInfo", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    vim.notify(
      "No active LSP clients attached to current buffer",
      vim.log.levels.WARN
    )
    return
  end

  local info = { "Active LSP Clients (Buffer " .. bufnr .. "):", "" }
  for _, client in ipairs(clients) do
    table.insert(info, string.format("• %s (ID: %d)", client.name, client.id))
    table.insert(
      info,
      string.format(
        "  Root dir: %s",
        client.config.root_dir or client.root_dir or "N/A"
      )
    )
    if client.config.cmd then
      table.insert(
        info,
        string.format("  Command:  %s", table.concat(client.config.cmd, " "))
      )
    end
    if client.config.filetypes then
      table.insert(
        info,
        string.format(
          "  Filetypes: %s",
          table.concat(client.config.filetypes, ", ")
        )
      )
    end
    table.insert(info, "")
  end

  print(table.concat(info, "\n"))
end, { desc = "Display attached LSP clients for current buffer" })

vim.schedule(function()
  require "mappings"
end)
