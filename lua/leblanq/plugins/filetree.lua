return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local ft = require("nvim-tree")
        ft.setup()

        vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end
}
