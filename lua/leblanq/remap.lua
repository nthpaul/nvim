vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "<C-c>", "<Esc>")

-- center with "zz" when navigating vertically
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP"]])
vim.keymap.set("n", "<M-F>", "gg=G``")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- tabpages
vim.keymap.set("n", "<leader>t", ":tabnew<CR>")
vim.keymap.set("n", "<leader>1", "1t")
vim.keymap.set("n", "<leader>2", "2t")
vim.keymap.set("n", "<leader>3", "3t")
vim.keymap.set("n", "<leader>4", "4t")
vim.keymap.set("n", "<leader>5", "5t")
vim.keymap.set("n", "<leader>6", "6t")
vim.keymap.set("n", "<leader>7", "7t")
vim.keymap.set("n", "<leader>8", "8t")
vim.keymap.set("n", "<leader>9", "9t")
vim.keymap.set("n", "<leader>0", ":tablast<CR>")
vim.keymap.set("n", "<leader>w", ":tabclose<CR>")
