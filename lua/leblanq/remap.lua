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
