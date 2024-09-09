return {
  {
    "stevearc/dressing.nvim",
    enabled = false,
    event = "VeryLazy",
  },
  {
    "b0o/schemastore.nvim",
    enabled = true,
    lazy = true,
  },
  -- Vim Plugins
  {
    "elkowar/yuck.vim",
    enabled = true,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    enabled = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type TailwindTools.Option
    opts = {
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = "inline", -- "inline" | "foreground" | "background"
        inline_symbol = "󰝤 ", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = false, -- can be toggled by commands
        symbol = "󱏿", -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = "#38BDF8",
        },
      },
      custom_filetypes = {}, -- see the extension section to learn how it works
    }, -- your configuration
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({
        heading = {
          enabled = false,
        },
        bullet = {
          enabled = false,
          -- icons = { "•", "", "◆", "◇" },
          -- "○"
          -- ""
        },
        dash = { width = 15 },
        checkbox = {
          enabled = true,
          custom = {
            in_progress = { raw = "[/]", rendered = "󱎖 ", highlight = "RenderMarkdownTodo" },
            fowarded = { raw = "[>]", rendered = ">", highlight = "RenderMarkdownUnchecked" },
            scheduled = { raw = "[<]", rendered = "󰨳 ", highlight = "RenderMarkdownUnchecked" },
          },
        },
      })
    end,
  },
}
