require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.hl.hl_op({ higroup = "IncSearch", timeout = "500" })
    end,
})

-- Remove whitespace on save
autocmd("BufWritePre", {
    pattern = "*",
    command = ":%s/\\s\\+$//e",
})

-- LSP onAttach
autocmd("LspAttach", {
    group = augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local map = vim.keymap.set

        -- 1. Navigation (Go To...)
        map("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
        map("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
        map("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
        map("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Show references" })

        -- 2. Information & Documentation
        map("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover Documentation" })
        map("n", "<leader>ls", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature Help" })

        -- 3. Actions (Rename, Code Action)
        map("n", "<leader>la", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
        map("n", "<leader>lr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename Symbol" })

        -- 4. Diagnostics
        map("n", "<leader>ld", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Line Diagnostics" })
        map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { buffer = ev.buf, desc = "Prev Diagnostic" })
        map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { buffer = ev.buf, desc = "Next Diagnostic" })

        -- 5. Formatting
        map("n", "<leader>lf", function()
            vim.lsp.buf.format { async = true }
        end, { buffer = ev.buf, desc = "Format Buffer" })

        -- 6. Inlay Hints
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            map("n", "<leader>lh", function()
                local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
                vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
            end, { buffer = ev.buf, desc = "Toggle Inlay Hints" })
        end
    end,
})

