return {
    "sindrets/diffview.nvim",
    config = function()
        require("diffview").setup({
            diff_binaries = false,
            key_bindings = {
                file_panel = {
                    ["j"] = "<Down>",
                    ["k"] = "<Up>",
                    ["<CR>"] = "select_entry",
                    ["o"] = "select_entry",
                    ["<2-LeftMouse>"] = "select_entry",
                    ["-"] = "toggle_stage_entry",
                    ["S"] = "stage_all",
                    ["U"] = "unstage_all",
                    ["X"] = "restore_entry",
                    ["R"] = "refresh_files",
                    ["<C-r>"] = "refresh_files",
                    ["<C-s>"] = "toggle_stage_entry",
                    ["<Tab>"] = "select_next_entry",
                    ["<S-Tab>"] = "select_prev_entry",
                    ["<C-q>"] = "close",
                    ["<Esc>"] = "close",
                },
                file_history_panel = {
                    ["g!"] = "options",
                    ["<C-q>"] = "close",
                    ["<Esc>"] = "close",
                },
            },
        })
    end,
}
