require("leblanq.set")
require("leblanq.remap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "leblanq.plugins",
    change_detection = { notify = false }
})

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

local augroup = vim.api.nvim_create_augroup
local leblanqGroup = augroup('leblanq', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd('LspAttach', {
    group = leblanqGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        -- commonly used
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>prn", function() vim.lsp.buf.rename() end, opts)

        -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        -- vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

        -- error diagnostics in current buffer
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>fd", function()
            vim.diagnostic.setloclist() -- or use setqflist({bufnr = 0}) if you prefer quickfix list
        end, { desc = "List buffer diagnostics" })

        vim.keymap.set("n", "<leader>pd", function()
            -- Get all diagnostics from the workspace
            vim.diagnostic.setqflist({
                severity = nil,  -- Get all severities
                workspace = true -- Get diagnostics from all files in workspace
            })
        end, { desc = "Project diagnostics" })
    end
})

-- add relative line numbers to built-in-file explore (netrw)
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
