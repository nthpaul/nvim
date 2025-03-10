return {
  "github/copilot.vim",
  config = function()
    vim.api.nvim_set_keymap('i', '<M-CR>', 'copilot#Accept("<CR>")', { expr = true, noremap = true, silent = true })
    vim.g.copilot_no_tab_map = true
    -- to avoid brainrot on startup
    vim.cmd(":Copilot disable")
    -- keymaps to disable and enable copilot
    vim.api.nvim_set_keymap('n', '<leader>cpd', ':Copilot disable<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>cpe', ':Copilot enable<CR>', { noremap = true, silent = true })
  end
}
