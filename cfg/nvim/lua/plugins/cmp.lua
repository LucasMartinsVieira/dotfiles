local icons = require("user.icons")
local kind_icons = icons.kind

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  enabled = true,
  dependencies = {
    { "hrsh7th/cmp-path", event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
    { "hrsh7th/cmp-nvim-lua", event = "InsertEnter" },
    { "hrsh7th/cmp-emoji", event = "InsertEnter" },
    { "hrsh7th/cmp-buffer", event = "InsertEnter" },
    { "L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip/loaders/from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },

      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),

        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),

        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      },

      --- @diagnostic disable: missing-fields
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            copilot = "[copilot]",
            nvim_lsp = "[LSP]",
            luasnip = "[snippet]",
            nvim_lua = "[nvim lua]",
            path = "[path]",
            buffer = "[buffer]",
            emoji = "[emoji]",
            crates = "[crates]",
          })[entry.source.name]

          if entry.source.name == "emoji" then
            vim_item.kind = icons.misc.Smiley
          end

          if entry.source.name == "crates" then
            vim_item.kind = icons.misc.Package
          end

          return vim_item
        end,
      },
      sources = {
        { name = "copilot" },
        { name = "nvim_lsp", option = { markdown_oxide = { keyword_pattert = [[\(\k\| \|\/\|#\)\+]] } } },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "vim-dadbod-completion" },
        { name = "emoji" },
        { name = "crates" },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = {
          border = "rounded",
          scrollbar = false,
          winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
        },
      },
      experimental = {
        ghost_text = true,
        native_menu = false,
      },
    })
  end,
}
