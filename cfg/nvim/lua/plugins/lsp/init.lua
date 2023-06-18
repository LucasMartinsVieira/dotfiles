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
      { "<space>lm", "<CMD>Mason<CR>",   desc = "Mason" },
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
          { name = "DiagnosticSignWarn",  text = icons.diagnostics.warning },
          { name = "DiagnosticSignHint",  text = icons.diagnostics.hint },
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

        local telescope = require('telescope.builtin')

        nmap("<space>lr", vim.lsp.buf.rename, "Rename")
        nmap("<space>la", vim.lsp.buf.code_action, "Code Action")
        nmap("<space>ld", vim.lsp.buf.type_definition, "Type Definition")
        nmap("<space>ls", telescope.lsp_document_symbols,"Document Symbols")
        nmap("<space>lS", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")

        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("gr", telescope.lsp_references, "[G]oto [R]eferences")
        nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        nmap("[d", vim.diagnostic.goto_prev, "Goto Previous Diagnostic")
        nmap("]d", vim.diagnostic.goto_next, "Goto Next Diagnostic")
        nmap("gl", vim.diagnostic.open_float, "Open Floating Diagnostic")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
      end

      local servers = {
        "bashls",
        "clangd",
        "html",
        "jsonls",
        "tsserver",
        "cssls",
        "lua_ls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "yamlls",
        "tailwindcss",
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
            require("lspconfig")["lua_ls"].settings = require("plugins.lsp.languages.lua_ls")
          end

          if server_name == "rust_analyzer" then
            require("lspconfig")["rust_analyzer"].settings =
                require("plugins.lsp.languages.rust")
          end

          if server_name == "tsserver" then
            require("lspconfig")["tsserver"].settings =
                require("plugins.lsp.languages.tsserver")
          end

          if server_name == "pyright" then
            require("lspconfig")["pyright"].settings =
                require("plugins.lsp.languages.pyright")
          end

          if server_name == "jsonls" then
            require("lspconfig")["jsonls"].settings = require("plugins.lsp.languages.jsonls")
          end

          if server_name == "yamlls" then
            require("lspconfig")["yamlls"].settings = require("plugins.lsp.languages.yamlls")
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
}
