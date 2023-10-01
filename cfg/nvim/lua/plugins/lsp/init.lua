return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Additional lua configuration, makes nvim stuff amazing
    { "folke/neodev.nvim", lazy = true },

    -- Use LSP for actions in Nvim-tree
    { "antosha417/nvim-lsp-file-operations", config = true },

    {
      -- Useful status updates for LSP
      "j-hui/fidget.nvim",
      enabled = true,
      tag = "legacy",
    },
  },
  config = function()
    local icons = require("user.icons")
    local function attach_navic(client, bufnr)
      vim.g.navic_silence = true
      local status_ok, navic = pcall(require, "nvim-navic")
      if not status_ok then
        return
      end
      navic.attach(client, bufnr)
    end

    local on_attach = function(client, bufnr)
      attach_navic(client, bufnr)

      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      local telescope = require("telescope.builtin")

      -- Useful LSP keybinds
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("gr", telescope.lsp_references, "[G]oto [R]eferences")
      nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("gl", vim.diagnostic.open_float, "Open floating Diagnostic")
      nmap("[d", vim.diagnostic.goto_prev, "Goto Previous Diagnostic")
      nmap("]d", vim.diagnostic.goto_next, "Goto Next Diagnostic")

      -- stylua: ignore
      nmap("<leader>li", "<CMD>LspInfo<CR>", "Connected Language Servers")
      nmap("<leader>lk", "<CMD>lua vim.lsp.buf.hover<CR>", "Hover Documentation")
      nmap("<leader>lK", "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Signature Help")
      nmap("<leader>lw", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder")
      nmap("<leader>lW", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder")
      nmap("<leader>lL", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folders")
      nmap("<leader>lt", "<CMD>lua vim.lsp.buf.type_definition()<CR>", "Type Definition")
      nmap("<leader>ld", "<CMD>lua vim.lsp.buf.definition()<CR>", "Go To Definition")
      nmap("<leader>lD", "<CMD>lua vim.lsp.buf.declaration()<CR>", "Go To declaration")
      nmap("<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename")
      nmap("<leader>lR", "<CMD>lua vim.lsp.buf.references()<CR>", "References")
      nmap("<leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action")
      nmap("<leader>le", "<CMD>luavim.diagnostic.open_float<CR>", "Show Line Diagnostics")
      nmap("<leader>ln", "<CMD>luavim.diagnostic.goto_next<CR>", "Go To Next Diagnostic")
      nmap("<leader>lp", "<CMD>luavim.diagnostic.goto_prev<CR>", "Go To Previous Diagnostic")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
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
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    -- Configuration for diagnostics
    local config = {
      -- disable virtual text
      virtual_text = true,
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

    -- Turn on lsp status information
    require("fidget").setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- No Mason
    lspconfig["lua_ls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = require("plugins.lsp.languages.lua_ls"),
    })

    lspconfig["rust_analyzer"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = require("plugins.lsp.languages.rust_analyzer"),
    })

    lspconfig["tsserver"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = require("plugins.lsp.languages.tsserver"),
    })

    lspconfig["bashls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig["nil_ls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig["html"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig["cssls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig["eslint"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig["jsonls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      -- cmd = { "vscode-json-languageserver", "--stdio" },
      settings = require("plugins.lsp.languages.jsonls"),
    })
  end,
}
