return {
  "williamboman/mason.nvim",
  enabled = false,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- Additional lua configuration, makes nvim stuff amazing
    { "folke/neodev.nvim", lazy = true },
  },
  config = function()
    local function on_attach(client, bufnr)
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Mason
      -- Setup mason so it can manage external tooling
      require("mason").setup()

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      local servers = {
        "bashls",
        "clangd",
        "html",
        "jsonls",
        "tsserver",
        "cssls",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        "tailwindcss",
      }

      mason_lspconfig.setup({
        --ensure_installed = vim.tbl_keys(servers),
        ensure_installed = servers,
      })

      -- mason_lspconfig.setup_handlers({
      --   function(server_name)
      --     require("lspconfig")[server_name].setup({
      --       capabilities = capabilities,
      --       on_attach = on_attach,
      --       --settings = servers[server_name],
      --     })
      --
      --     if server_name == "lua_ls" then
      --       require("lspconfig")["lua_ls"].settings =
      --         require("plugins.lsp.languages.lua_ls")
      --     end
      --
      --     if server_name == "rust_analyzer" then
      --       require("lspconfig")["rust_analyzer"].settings =
      --         require("plugins.lsp.languages.rust_analyzer")
      --     end
      --
      --     if server_name == "tsserver" then
      --       require("lspconfig")["tsserver"].settings =
      --         require("plugins.lsp.languages.tsserver")
      --     end
      --
      --     if server_name == "pyright" then
      --       require("lspconfig")["pyright"].settings =
      --         require("plugins.lsp.languages.pyright")
      --     end
      --
      --     if server_name == "jsonls" then
      --       require("lspconfig")["jsonls"].settings =
      --         require("plugins.lsp.languages.jsonls")
      --     end
      --
      --     if server_name == "yamlls" then
      --       require("lspconfig")["yamlls"].settings =
      --         require("plugins.lsp.languages.yamlls")
      --     end
      --   end,
      -- })
    end
  end,
}
