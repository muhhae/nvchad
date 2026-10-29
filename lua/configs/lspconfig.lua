require("nvchad.configs.lspconfig").defaults()

vim.filetype.add {
  extension = { jsonc = "jsonc" },
  filename = {
    ["tsconfig.json"] = "jsonc",
    ["jsconfig.json"] = "jsonc",
    ["bunfig.json"] = "jsonc",
  },
  pattern = {
    ["%.vscode/.*%.json"] = "jsonc",
    ["%.code%-workspace"] = "jsonc",
  },
}

local servers = { "html", "cssls", "gopls", "clangd" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
