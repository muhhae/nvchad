require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt = "both" -- to enable cursorline!
o.wrap = false
o.swapfile = false
o.relativenumber = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
