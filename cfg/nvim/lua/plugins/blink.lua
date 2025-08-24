return {
  "saghen/blink.cmp",
  enabled = true,
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- "saghen/blink.compat",
    -- -- CMP completions
    -- { "hrsh7th/cmp-emoji", event = "InsertEnter" },
  },

  version = "1.*",

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
      -- use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      menu = {
        -- Don't automatically show the completion menu
        auto_show = true,

        border = "single",

        -- nvim-cmp style menu
        -- draw = {
        --   columns = {
        --     { "label", "label_description", gap = 1 },
        --     { "kind_icon", "kind" },
        --   },
        --   components = {
        --     kind_icon = {
        --       text = function(ctx)
        --         local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
        --         return kind_icon
        --       end,
        --       -- (optional) use highlights from mini.icons
        --       highlight = function(ctx)
        --         local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
        --         return hl
        --       end,
        --     },
        --     kind = {
        --       -- (optional) use highlights from mini.icons
        --       highlight = function(ctx)
        --         local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
        --         return hl
        --       end,
        --     },
        --   },
        -- },
      },
    },

    -- snippets = {
    --   preset = "luasnip",
    -- },

    signature = { enabled = true, window = { show_documentation = true } },

    sources = {
      -- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates", "obsidian", "obsidian_new", "obsidian_tags" },
      -- default = { "lsp", "path", "snippets", "buffer", "emoji", "crates" },
      default = { "lsp", "path", "snippets", "buffer" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
