require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- map("x", "P", '"_dP')
-- map("x", "p", function()
--   if vim.fn.mode() == "V" then
--     return '"_dP'
--   end
--
--   return '"_dp'
-- end, { expr = true })
map("x", "P", '"_dP')
map("x", "p", '"_dP')
-- USE HJKL
-- map({ "n", "x" }, "<Up>", "<cmd>echo 'Use k!'<CR>")
-- map({ "n", "x" }, "<Down>", "<cmd>echo 'Use j!'<CR>")
-- map({ "n", "x" }, "<Left>", "<cmd>echo 'Use h!'<CR>")
-- map({ "n", "x" }, "<Right>", "<cmd>echo 'Use l!'<CR>")

map("n", "<C-f>", [[:%s~~~gI<left><Left><Left><Left>]])
map("x", "<C-f>", [[:s~~~gI<left><Left><Left><Left>]])

map({ "i", "v" }, "<C-c>", "<Esc>", { desc = "Close window" })

map("n", "<C-w>-", "<cmd>split<CR>", { desc = "Horizotal Split" })
map("n", "<C-w>\\", "<cmd>vsplit<CR>", { desc = "Vertical Split" })

map("n", "<leader>e", "<CMD>Neotree<CR>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "v" }, "d", '"_d')
map("n", "dd", '"_dd')

map({ "n", "i", "x" }, "<C-x>", "<cmd> wqa! <cr>")

map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })

map("n", "vw", "viw", { desc = "Select current word" })
map("n", "vW", "viW", { desc = "Select current WORD" })
map("n", "vs", "viws", { desc = "Select current word and replace" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> wa <cr>")
map("n", "<leader>tt", require("base46").toggle_transparency, { desc = "Toggle transparency" })

map("n", "<leader>w", ":set wrap!<CR>", { silent = true })

-- Keyboard users
map("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
map({ "n", "v" }, "<RightMouse>", function()
  require("menu.utils").delete_old_menus()

  vim.cmd.exec('"normal! \\<RightMouse>"')

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

map({ "n", "v" }, "<leader>fs", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Document Symbols" })

map({ "n", "v" }, "<leader>fS", "<CMD>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" })
