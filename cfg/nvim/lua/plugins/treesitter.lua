return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
      "HiPhish/nvim-ts-rainbow2",
      "nvim-treesitter/nvim-treesitter-context"
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Schrink selection",  mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "bash",
        -- "help",
        "regex",
        "c",
        "html",
        "javascript",
        "typescript",
        "json",
        "lua",
        "markdown",
        "rust",
        "python",
        "javascript",
        "typescript",
        "vim",
        "yaml",
      },
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
      },
      rainbow = {
        enable = true,
        extended_mode = true,  -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
      },
    },
    -- -@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require 'treesitter-context'.setup {
        enable = false,      -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,      -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',    -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },
}
