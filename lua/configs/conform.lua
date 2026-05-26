local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff" },
    typescript = { "oxfmt" },
    javascript = { "oxfmt" },
    typescriptreact = { "oxfmt" },
    javascriptreact = { "oxfmt" },
    html = { "oxfmt" },
    css = { "oxfmt" },
    vue = { "oxfmt" },
    json = { "oxfmt" },
    blade = { "blade-formatter" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
