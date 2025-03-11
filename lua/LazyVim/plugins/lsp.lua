return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "j-hui/fidget.nvim"
  },

  config = function()
    require("conform").setup {
      formatters_by_ft = {
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 5000,
      },
      notify_on_error = true,
      notify_no_formatters = true
    }

    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = {
        "ts_ls",
        "clangd",
        "tailwindcss",
        "dockerls",
        "elixirls",
        "gopls",
        "graphql",
        "html",
        "jdtls",
        "eslint",
        "jsonls",
        "ltex",
        "lua_ls",
        "nginx_language_server",
        "prismals",
        "buf_ls",
        "ruff",
        "sqlls",
        "terraformls",
        "yamlls",
        "zls",
        "bashls"
      },
      automatic_installation = true
    }
    require("mason-lspconfig").setup_handlers {
      function(server_name)
        require("lspconfig")[server_name].setup {
          capabilities = capabilities
        }
      end,

      ["eslint"] = function()
        local lspconfig = require("lspconfig")

        lspconfig.eslint.setup({
          capabilities = capabilities,
          -- root_dir = require("lspconfig.util").root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js"),
          settings = {
            workingDirectory = { mode = "location" },
            format = true,
          },
          -- root_dir = lspconfig.util.find_git_ancestor,
          root_dir = vim.fs.dirname(vim.fs.find('.git', { path = startpath, upward = true })[1])
        })
      end,
    }

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-q>"] = cmp.mapping.abort()

      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }, {
        { name = "buffer" },
      }),
    })

    -- Diagnostics config (unchanged)
    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
    })
  end
}
