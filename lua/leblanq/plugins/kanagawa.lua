return {
    "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({
            terminalColors = true,
            bold = true,
            transparent = true
        })
    end
}
