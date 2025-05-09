return {
  "neovim/nvim-lspconfig",
  enabled = "true",
  dependencies = {
    -- Additional lua configuration, makes nvim stuff amazing
    -- { "folke/lazydev", ft = "lua", lazy = true },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      },
    },
    "saghen/blink.cmp",

    -- Use LSP for actions in Nvim-tree
    -- { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local icons = require("user.icons")
    -- local telescope = require("telescope.builtin")

    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- stylua: ignore
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("gd", function()
      Snacks.picker.lsp_definitions()
    end, "Goto Definition")
    nmap("gD", function()
      Snacks.picker.lsp_declarations()
    end, "[G]oto [D]eclaration")
    nmap("gr", function()
      Snacks.picker.lsp_references()
    end, "[G]oto [R]eferences")
    nmap("gI", function()
      Snacks.picker.lsp_implementations()
    end, "[G]oto [I]mplementation")
    nmap("gy", function()
      Snacks.picker.lsp_type_definitions()
    end, "[G]oto T[y]pe Definition")
    nmap("gl", vim.diagnostic.open_float, "Open floating Diagnostic")
    nmap("[d", vim.diagnostic.goto_prev, "Goto Previous Diagnostic")
    nmap("]d", vim.diagnostic.goto_next, "Goto Next Diagnostic")

    -- stylua: ignore
    nmap("<leader>li", "<CMD>LspInfo<CR>", "Connected Language Servers")
    nmap("<leader>lf", "<CMD>lua vim.lsp.buf.format({ async = true })<CR>", "Format")
    nmap("<leader>lK", "<CMD>lua vim.lsp.buf.signature_help<CR>", "Signature Help")
    nmap("<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename")
    nmap("<leader>la", "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code Action")

    nmap("<leader>lws", function()
      Snacks.picker.lsp_symbols()
    end, "Workspace Symbols")
    nmap("<leader>lwS", function()
      Snacks.picker.lsp_workspace_symbols()
    end, "Workspace Symbols")
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
      -- "marksman",
      "markdown_oxide",
      "nil_ls",
      "prismals",
      "pyright",
      -- "rust_analyzer",
      -- "statix",
      "tailwindcss",
      "taplo",
      "ts_ls",
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

      -- if server == "lua_ls" then
      --   ---@diagnostic disable-next-line: missing-fields
      --   require("neodev").setup({
      --     library = {
      --       plugins = { "nvim-dap-ui" },
      --       types = true,
      --     },
      --   })
      -- end

      if server == "markdown_oxide" then
        vim.api.nvim_create_user_command("Daily", function(args)
          local input = args.args

          vim.lsp.buf.execute_command({ command = "jump", arguments = { input } })
        end, { desc = "Open Daily note", nargs = "*" })
      end

      lspconfig[server].setup(opts)
    end
  end,
}
