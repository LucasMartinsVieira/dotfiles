return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Additional lua configuration, makes nvim stuff amazing
    { "folke/neodev.nvim", lazy = true },

    -- Use LSP for actions in Nvim-tree
    { "antosha417/nvim-lsp-file-operations", config = true },
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
    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", telescope.lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("gl", vim.diagnostic.open_float, "Open floating Diagnostic")
    nmap("[d", vim.diagnostic.goto_prev, "Goto Previous Diagnostic")
    nmap("]d", vim.diagnostic.goto_next, "Goto Next Diagnostic")

    -- stylua: ignore
    nmap("<leader>li", "<CMD>LspInfo<CR>", "Connected Language Servers")
    nmap("<leader>lf", "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", "Format")
    nmap("<leader>lh", "<CMD>lua require 'user.functions'.toggle_inlay_hints()<CR>", "Hints")
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
    nmap("<leader>le", "<CMD>lua vim.diagnostic.open_float<CR>", "Show Line Diagnostics")
    nmap("<leader>ln", "<CMD>lua vim.diagnostic.goto_next<CR>", "Go To Next Diagnostic")
    nmap("<leader>lp", "<CMD>lua vim.diagnostic.goto_prev<CR>", "Go To Previous Diagnostic")

    local function attach_navic(client, bufnr)
      vim.g.navic_silence = true
      local status_ok, navic = pcall(require, "nvim-navic")
      if not status_ok then
        return
      end

      if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlayHint.enable(bufnr, true)
      end

      navic.attach(client, bufnr)
    end

    local on_attach = function(client, bufnr)
      attach_navic(client, bufnr)

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format current buffer with LSP" })
    end

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
      virtual_text = true,
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

    local function common_capabilities()
      local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if status_ok then
        return cmp_nvim_lsp.default_capabilities()
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }

      return capabilities
    end

    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    local servers = {
      "bashls",
      "biome",
      "cssls",
      -- "eslint",
      "html",
      "jsonls",
      "lua_ls",
      "marksman",
      "nil_ls",
      "rust_analyzer",
      "tailwindcss",
      "taplo",
      "tsserver",
      "yamlls",
    }

    for _, server in pairs(servers) do
      local opts = {
        on_attach = on_attach,
        capabilities = common_capabilities(),
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
