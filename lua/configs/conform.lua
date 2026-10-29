local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clang-format" },
    c = { "clang-format" },
    go = { "gofumpt", "golines" },
    css = { "prettierd" },
    html = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    markdown = { "prettierd" },
    bash = { "beautysh" },
    python = { "ruff" },
    sh = { "beautysh" },
    ["*"] = { "codespell" },
    ["_"] = { "trim_whitespace" },
  },
  formatters = {
    prettier = {},
  },
  format_on_save = function(bufnr)
    -- Explicit saves during Insert/Replace mode should not interrupt editing.
    local mode = vim.api.nvim_get_mode().mode
    if mode:match "^[iR]" or not vim.bo[bufnr].modified then
      return
    end

    return {
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
}

return options
