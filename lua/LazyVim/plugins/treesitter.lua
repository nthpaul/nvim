return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "luadoc",
        "vim",
        "javascript",
        "typescript",
        "tsx",
        "ruby",
        "elixir",
        "rust",
        "python",
        "json",
        "jsonc",
        "jsdoc",
        "yaml",
        "html",
        "css",
        "scss",
        "toml",
        "markdown",
        "graphql",
        "svelte",
        "haskell",
        "java",
        "php",
        "bash",
        "dockerfile",
        "vim",
        "vimdoc",
        "go",
        "xml",
        "yaml"
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
