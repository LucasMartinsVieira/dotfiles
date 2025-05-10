return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  enabled = false,
  build = ":TSUpdate",
  -- event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- "nvim-treesitter/nvim-treesitter-context",
    "JoosepAlviste/nvim-ts-context-commentstring",
    {
      "windwp/nvim-ts-autotag",
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-ts-autotag").setup({
          opts = {
            -- Defaults
            enable_close = true, -- Auto close tags
            enable_rename = true, -- Auto rename pairs of tags
            enable_close_on_slash = false, -- Auto close on trailing </
          },
        })
      end,
    },
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "comment",
      "regex",
      "c",
      "html",
      -- "java",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "rust",
      "vim",
      "vimdoc",
      "yaml",
    },

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<nop>",
        node_decremental = "<bs>",
      },
    },
  },
  --- @param opts TSConfig
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
