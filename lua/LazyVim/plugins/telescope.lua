return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      extensions = {
        file_browser = {
          grouped = true,
          sorting_strategy = 'ascending',
        }
      }
    })

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>pd', builtin.lsp_definitions, { desc = 'Telescope lsp definitions' })
    vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'Telescope lsp references' })
    vim.keymap.set('n', '<leader>pn', ":Telescope notify<CR>", { desc = 'Telescope notify' })
    vim.keymap.set('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Tescope code action" })
    vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", { desc = "Telescope git status " })

    -- telescope file browser
    vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "Telescope file browser " })
  end
}
