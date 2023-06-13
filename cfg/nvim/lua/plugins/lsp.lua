local icons = require("user.icons")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      {
        -- Useful status updates for LSP
        "j-hui/fidget.nvim",
        tag = "legacy",
      },

      -- Additional lua configuration, makes nvim stuff amazing
      "folke/neodev.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "Mason", "LspInfo" },
    keys = {
      { "<space>lm", "<CMD>Mason<CR>", desc = "Mason" },
      { "<space>li", "<CMD>LspInfo<CR>", desc = "Lsp Info" },
    },
    config = function()
      local function attach_navic(client, bufnr)
        vim.g.navic_silence = true
        local status_ok, navic = pcall(require, "nvim-navic")
        if not status_ok then
          return
        end
        navic.attach(client, bufnr)
      end
      -- LSP settings.
      --  This function gets run when an LSP connects to a particular buffer.
      -- local on_attach = function(_, client, bufnr)
      local on_attach = function(client, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        attach_navic(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        -- Custom Icons for LSP Diagnostics
        local signs = {
          { name = "DiagnosticSignError", text = icons.diagnostics.error },
          { name = "DiagnosticSignWarn", text = icons.diagnostics.warning },
          { name = "DiagnosticSignHint", text = icons.diagnostics.hint },
          {
            name = "DiagnosticSignInfo",
            text = icons.diagnostics.information,
          },
        }

        for _, sign in ipairs(signs) do
          vim.fn.sign_define(
            sign.name,
            { texthl = sign.name, text = sign.text, numhl = "" }
          )
        end

        -- Setup neovim lua configuration
        require("neodev").setup()

        local config = {
          -- disable virtual text
          virtual_text = false,
          update_in_insert = true,
          underline = true,
          severity_sort = true,
          signs = {
            active = signs,
          },
          float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        }

        vim.diagnostic.config(config)

        nmap("<space>lr", vim.lsp.buf.rename, "Rename")
        nmap("<space>la", vim.lsp.buf.code_action, "Code Action")
        nmap("<space>ld", vim.lsp.buf.type_definition, "Type Definition")
        nmap(
          "<space>ls",
          require("telescope.builtin").lsp_document_symbols,
          "Document Symbols"
        )
        nmap(
          "<space>lS",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          "Workspace Symbols"
        )

        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap(
          "gr",
          require("telescope.builtin").lsp_references,
          "[G]oto [R]eferences"
        )
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

        -- See `:help K` for why this keymap
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Diagnostic keymaps
        nmap("[d", vim.diagnostic.goto_prev, "Goto Previous Diagnostic")
        nmap("]d", vim.diagnostic.goto_next, "Goto Next Diagnostic")
        nmap("gl", vim.diagnostic.open_float, "Open Floating Diagnostic")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
      end

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      local servers = {
        "bashls",
        "clangd",
        "html",
        "jsonls",
        "tsserver",
        "gopls",
        "cssls",
        "lua_ls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "taplo",
        "yamlls",
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Setup mason so it can manage external tooling
      require("mason").setup()

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        --ensure_installed = vim.tbl_keys(servers),
        ensure_installed = servers,
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            --settings = servers[server_name],
          })

          if server_name == "lua_ls" then
            require("lspconfig")["lua_ls"].settings = require("user.lsp.lua_ls")
          end

          if server_name == "rust_analyzer" then
            require("lspconfig")["rust_analyzer"].settings =
              require("user.lsp.rust")
          end

          if server_name == "tsserver" then
            require("lspconfig")["tsserver"].settings =
              require("user.lsp.tsserver")
          end

          if server_name == "pyright" then
            require("lspconfig")["pyright"].settings =
              require("user.lsp.pyright")
          end

          if server_name == "jsonls" then
            require("lspconfig")["jsonls"].settings = require("user.lsp.jsonls")
          end

          if server_name == "yamlls" then
            require("lspconfig")["yamlls"].settings = require("user.lsp.yamlls")
          end
        end,
      })

      -- Turn on lsp status information
      require("fidget").setup()
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    keys = {
      { "<space>lf", "<CMD>lua vim.lsp.buf.format()<CR>", desc = "Format" },
    },
    config = function()
      local null_ls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      null_ls.setup({
        debug = false,
        sources = {
          formatting.prettier.with({
            extra_filetypes = { "toml", "solidity" },
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
          }),
          formatting.black.with({ extra_args = { "--fast" } }),
          formatting.stylua,
          formatting.rustfmt,
          formatting.shfmt,
          diagnostics.shellcheck,
          diagnostics.eslint,
        },
      })

      local unwrap = {
        method = null_ls.methods.DIAGNOSTICS,
        filetypes = { "rust" },
        generator = {
          fn = function(params)
            local diagnostics = {}

            -- sources have access to a params object
            -- containing info about the current file and editor state
            for i, line in ipairs(params.content) do
              local col, end_col = line:find("unwrap()")
              if col and end_col then
                -- null-ls fills in undefined positions
                -- and converts source diagnostics into the required format
                table.insert(diagnostics, {
                  row = i,
                  col = col,
                  end_col = end_col,
                  source = "unwrap",
                  message = "hey "
                    .. os.getenv("USER")
                    .. ", don't forget to handle this",
                  severity = 2,
                })
              end
            end
            return diagnostics
          end,
        },
      }

      null_ls.register(unwrap)
    end,
  },
}
