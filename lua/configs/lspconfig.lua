require("nvchad.configs.lspconfig").defaults()

local servers = { "gopls", "clangd", "ty", "rust_analyzer", "intelephense", "ts_ls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
