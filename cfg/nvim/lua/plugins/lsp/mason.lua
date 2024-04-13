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
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Mason
    -- Setup mason so it can manage external tooling
    require("mason").setup()

    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")

    local servers = {
      -- "bashls",
      -- "clangd",
      -- "html",
      -- "jsonls",
      -- "tsserver",
      -- "cssls",
      -- "lua_ls",
      -- "marksman",
      -- "rust_analyzer",
      -- "tailwindcss",
      "taplo",
    }

    mason_lspconfig.setup({
      --ensure_installed = vim.tbl_keys(servers),
      ensure_installed = {
        "taplo",
      },
    })
  end,
}
