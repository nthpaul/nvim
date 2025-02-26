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
    require("conform").setup({
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        json = { "prettier" },
        javascript = { "prettier", "prettierd", lsp_format = "fallback" },
        typescript = { "prettier", "prettierd", lsp_format = "fallback" },
        lua = { "stylua", lsp_format = "falllback" },
        rust = { "rustfmt", lsp_format = "fallback" },
        go = { "gofmt", lsp_format = "fallback" },
        elixir = { lsp_format = "fallback" },
        python = function(bufnr)
          local conform = require("conform")
          if
              conform.get_formatter_info("isort", bufnr).available
              and conform.get_formatter_info("black", bufnr).available
          then
            return { "isort", "black" }
          elseif conform.get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { lsp_format = "fallback" }
          end
        end,
      },
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
        debug = true,
      },
    })
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

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
        -- "ruff",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                },
              },
            },
          })
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
            root_dir = lspconfig.util.find_git_ancestor,
          })
        end,

        ["elixirls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.elixirls.setup({
            capabilities = capabilities,
            cmd = { "elixir-ls" },
            -- root_dir = lspconfig.util.root_pattern("mix.exs", ".git"),
            settings = {
              workingDirectory = { mode = "location" },
              format = true,
            },
            root_dir = lspconfig.util.find_git_ancestor,
          })
        end,

        ["tailwindcss"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            cmd = { "tailwindcss-language-server", "--stdio" },
            filetypes = {
              "html",
              "css",
              "scss",
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
            },
            root_dir = lspconfig.util.root_pattern(
              "tailwind.config.js",
              "tailwind.config.cjs",
              "tailwind.config.ts"
            ),
          })
        end,

        ["ts_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern(
              "package.json",
              "tsconfig.json",
              "jsconfig.json",
              ".git"
            ),
          })
        end,

        ["ruff"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.ruff.setup({
            capabilities = capabilities,
            -- Increase Node.js memory limit (default is 4096 MB)
            cmd = {
              "node",
              "--max-old-space-size=4096", -- Increase to 4GB (adjust as needed)
              vim.fn.expand("~/.local/share/nvim/mason/bin/pyright-langserver"),
              "--stdio",
            },
            settings = {

              workingDirectory = { mode = "location" },
              format = true,
              python = {
                pythonPath = vim.fn.exepath("python"), -- Use your Python interpreter
              },
            },
            root_dir = lspconfig.util.find_git_ancestor,
          })
        end,
      },
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
      }, {
        { name = "buffer" },
      }),
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
  end,
}
