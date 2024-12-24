return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "javascript", "typescript", "ruby", "elixir", "rust", "python", "json", "yaml", "html", "css", "scss", "graphql", "svelte", "haskell", "java", "php", "bash", "dockerfile", "go", "yaml" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
