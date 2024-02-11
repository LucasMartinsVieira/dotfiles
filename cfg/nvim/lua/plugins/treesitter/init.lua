return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
  },
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    -- context_commentstring = { enable = true, enable_autocmd = false },
    -- ts_context_commentstring = { enable = true, enable_autocmd = false },
    ensure_installed = {
      "bash",
      "comment",
      -- "help",
      "regex",
      "c",
      "html",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "rust",
      "python",
      "vim",
      "vimdoc",
      "yaml",
    },

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<nop>",
        node_decremental = "<bs>",
      },
    },

    -- Auto closing html tags
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,
      filetypes = { "html", "javascriptreact", "typescriptreact", "tsx" },
    },
  },
  --- @param opts TSConfig
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    require("nvim-ts-autotag").setup()
  end,
}
