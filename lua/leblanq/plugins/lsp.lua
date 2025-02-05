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
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },


  config = function()
    local lang_formatters = {
      javascript = { "prettier", lsp_format = "fallback" },
      typescript = { "prettier", lsp_format = "fallback" },
      lua = { "stylua", lsp_format = "fallback" },
      rust = { "rustfmt", lsp_format = "fallback" },
      go = { "gofmt", lsp_format = "fallback" },
      elixirls = { lsp_format = "fallback" },
      python = { "isort", "black", lsp_format = "fallback" },
      html = { "prettier", lsp_format = "fallback" },
      c = { lsp_format = "fallback" },
      cpp = { lsp_format = "fallback" },
      css = { "prettier", lsp_format = "fallback" },
      scss = { "prettier", lsp_format = "fallback" },
      json = { "prettier", lsp_format = "fallback" },
      graphql = { "prettier", lsp_format = "fallback" },
      markdown = { "prettier", lsp_format = "fallback" },
      yaml = { "prettier", lsp_format = "fallback" },
      sql = { lsp_format = "fallback" },
      latex = { "latexindent", lsp_format = "fallback" },
      tailwindcss = { "prettier", lsp_format = "fallback" },
      zig = { lsp_format = "fallback" },
      zls = { lsp_format = "fallback" },
      ltex = { "latexindent", lsp_format = "fallback" },
    }

    require("conform").setup({
      formatters_by_ft = lang_formatters,
      format_on_save = {
        timeout_ms = 10000,
        lsp_format = "fallback",
      }
    })
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "elixirls",
        "tailwindcss",
        "eslint",
        "ts_ls",
        "pyright",
        "html",
        "clangd",
        "zls",
        "sqls",
        "ltex",
        "graphql"
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,


        ["eslint"] = function()
          local lspconfig = require("lspconfig")

          lspconfig.eslint.setup({
            capabilities = capabilities,
            -- root_dir = require("lspconfig.util").root_pattern(".eslintrc", ".eslintrc.json", ".eslintrc.js"),
            settings = {
              workingDirectory = { mode = "location" },
              format = true
            },
            root_dir = lspconfig.util.find_git_ancestor,
          })
        end,

        ["elixirls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.elixirls.setup {
            capabilities = capabilities,
            cmd = { "elixir-ls" },
            -- root_dir = lspconfig.util.root_pattern("mix.exs", ".git"),
            settings = {
              workingDirectory = { mode = "location" },
              format = true
            },
            root_dir = lspconfig.util.find_git_ancestor,
          }
        end,

        ["tailwindcss"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.tailwindcss.setup {
            capabilities = capabilities,
            cmd = { "tailwindcss-language-server", "--stdio" },
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
          }
        end,

        ["ts_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.ts_ls.setup {
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
          }
        end,
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
