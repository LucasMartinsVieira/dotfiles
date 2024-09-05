return {
  "neovim/nvim-lspconfig",
  enabled = "true",
  dependencies = {
    -- Additional lua configuration, makes nvim stuff amazing
    { "folke/neodev.nvim", lazy = true },

    -- Use LSP for actions in Nvim-tree
    -- { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local icons = require("user.icons")
    local telescope = require("telescope.builtin")

    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- Useful LSP keybinds
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
    nmap("gr", telescope.lsp_references, "[G]oto [R]eferences")
    nmap("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gl", vim.diagnostic.open_float, "Open floating Diagnostic")
    nmap("[d", vim.diagnostic.goto_prev, "Goto Previous Diagnostic")
    nmap("]d", vim.diagnostic.goto_next, "Goto Next Diagnostic")

    -- stylua: ignore
    nmap("<leader>li", "<CMD>LspInfo<CR>", "Connected Language Servers")
    nmap("<leader>lf", "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", "Format")
    nmap("<leader>lh", "<CMD>lua require 'user.lsp_functions'.toggle_lsp_inlayhints()<CR>", "Inlay Hints")
    nmap("<leader>lK", "<CMD>lua vim.lsp.buf.signature_help<CR>", "Signature Help")
    nmap("<leader>ld", "<CMD>Telescope lsp_document_symbols<CR>", "Document Symbols")
    nmap("<leader>lt", "<CMD>Telescope lsp_type_definitions<CR>", "Type Definition")
    nmap("<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename")
    nmap("<leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action")
    nmap("<leader>lws", "<CMD>lua Telescope lsp_workspace_symbols<CR>", "Workspace Symbols")
    nmap("<leader>lwa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder")
    nmap("<leader>lwr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder")
    nmap("<leader>lwl", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folders")

    -- Custom Icons for LSP Diagnostics
    local signs = {
      { name = "DiagnosticSignError", text = icons.diagnostics.Error },
      { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
      { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
      {
        name = "DiagnosticSignInfo",
        text = icons.diagnostics.Information,
      },
    }

    for _, sign in ipairs(signs) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    -- Configuration for diagnostics
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
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    local servers = {
      "bashls",
      -- "biome",
      "cssls",
      "eslint",
      "gopls",
      "html",
      -- "jdtls",
      "jsonls",
      "lua_ls",
      "marksman",
      "nil_ls",
      "prismals",
      -- "rust_analyzer",
      "statix",
      "tailwindcss",
      "taplo",
      "tsserver",
      "yamlls",
    }

    local lsp_functions = require("user.lsp_functions")

    for _, server in pairs(servers) do
      local opts = {
        on_attach = lsp_functions.on_attach,
        capabilities = lsp_functions.common_capabilities(),
      }

      local require_ok, settings = pcall(require, "plugins.lsp.languages." .. server)
      if require_ok then
        opts = vim.tbl_deep_extend("force", settings, opts)
      end

      if server == "lua_ls" then
        require("neodev").setup({
          library = {
            plugins = { "nvim-dap-ui" },
            types = true,
          },
        })
      end

      lspconfig[server].setup(opts)
    end
  end,
}
