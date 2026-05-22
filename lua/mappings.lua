require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "v" }, "d", '"_d')
map("n", "dd", '"_dd')

map({ "n", "i", "v" }, "<C-x>", "<cmd> wqa <cr>")

map("n", "<C-f>", [[:%s~~~gI<left><Left><Left><Left>]])
map("x", "<C-f>", [[:s~~~gI<left><Left><Left><Left>]])

map("n", "vw", "viw", { desc = "Select current word" })
map("n", "vW", "viW", { desc = "Select current WORD" })
map("n", "vs", "viws", { desc = "Select current word and replace" })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
