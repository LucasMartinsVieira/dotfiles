return {
  "saghen/blink.cmp",
  enabled = false,
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saghen/blink.compat",
    -- CMP completions
    { "hrsh7th/cmp-emoji", event = "InsertEnter" },
  },

  version = "*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "none",

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-y>"] = { "select_and_accept" },

      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-l>"] = { "snippet_forward", "fallback" },
      ["<C-h>"] = { "snippet_backward", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    -- snippets = {
    --   preset = "luasnip",
    -- },

    signature = { enabled = true },

    sources = {
      -- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates", "obsidian", "obsidian_new", "obsidian_tags" },
      default = { "lsp", "path", "snippets", "buffer", "emoji", "crates" },

      providers = {
        emoji = { name = "emoji", module = "blink.compat.source" },
        crates = { name = "crates", module = "blink.compat.source" },

        -- obsidian = { name = "obsidian", module = "blink.compat.source" },
        -- obsidian_new = { name = "obsidian_new", module = "blink.compat.source" },
        -- obsidian_tags = { name = "obsidian_tags", module = "blink.compat.source" },
      },
    },
  },
  opts_extend = { "sources.default" },
}
