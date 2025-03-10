local vault = os.getenv("HOME") .. "/Documents/obsidian"
local icons = require("user.icons")

if not vim.uv.fs_stat(vault) then
  return {}
end

return {
  {
    "epwalsh/obsidian.nvim",
    enabled = true,
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    keys = {
      { "<leader>sf", "<CMD>ObsidianFollowLink<CR>", desc = "Follow Link" },
      { "<leader>sb", "<CMD>ObsidianBackLinks<CR>", desc = "Back Links" },
      { "<leader>st", "<CMD>ObsidianTags<CR>", desc = "Obsidian Tags" },
      { "<leader>sr", "<CMD>ObsidianRename<CR>", desc = "Obsidian Rename" },
      { "<leader>so", "<CMD>ObsidianOpen<CR>", desc = "Obsidian Open" },
      { "<leader>sq", "<CMD>ObsidianQuickSwitch<CR>", desc = "Obsidian QuickSwitch" },
      { "<leader>sl", "<CMD>ObsidianLinks<CR>", desc = "Obsidian Links" },
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      workspaces = {
        {
          name = "obsidian",
          path = vault,
        },
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,

        -- Trigger completion at 2 chars.
        min_chars = 2,

        -- Where to put new notes created from completion. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        -- new_notes_location = "current_dir",

        -- Control how wiki links are completed with these (mutually exclusive) options:
        --
        -- 1. Whether to add the note ID during completion.
        -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
        -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
        -- prepend_note_id = true,
        -- 2. Whether to add the note path during completion.
        -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
        -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
        -- prepend_note_path = false,
        -- 3. Whether to only use paths during completion.
        -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
        -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
        -- use_path_only = false,
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },

      ui = {
        enable = false, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = icons.ui.Square, hl_group = "ObsidianTodo" },
          ["x"] = { char = icons.ui.SquareDone, hl_group = "ObsidianDone" },
          [">"] = { char = icons.ui.ChevronRight, hl_group = "ObsidianRightArrow" },
          ["~"] = { char = icons.ui.Canceled, hl_group = "ObsidianTilde" },
          ["/"] = { char = "󱎖 ", hl_group = "ObsidianTodo" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
        },
      },
      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = true,
    },
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
          enabled = true,
          icons = { "•", "", "•", "" },
          -- highlight = "RenderMarkdownH4",
        },
        dash = { width = 15 },
        pipe_table = {
          enabled = false,
          preset = "round",
        },
        checkbox = {
          enabled = true,
          unchecked = {
            icon = "󰄱",
          },
          checked = {
            icon = "󰄲",
          },
          custom = {
            in_progress = { raw = "[/]", rendered = "󱎖", highlight = "RenderMarkdownTodo" },
            fowarded = { raw = "[>]", rendered = icons.ui.ChevronRight, highlight = "RenderMarkdownTodo" },
            scheduled = { raw = "[<]", rendered = "󰨳", highlight = "RenderMarkdownTodo" },
          },
        },
      })
    end,
  },
  {
    "ray-x/yamlmatter.nvim",
    enabled = false,
    config = function()
      require("yamlmatter").setup({
        icon_mappings = {
          title = "",
          date = "󰨳",
          week = "󰨳",
          time = "",
          tags = "󰓹",
          -- enjoyment = "󰱱",
          -- aliases = "󱞫",
          -- related = "",
          default = "󰦨",
        },
        highlight_groups = {
          icon = "MyIconHighlight",
          key = "MyKeyHighlight",
          value = "MyValueHighlight",
        },
        key_value_padding = 2, -- Less space
      })
    end,
  },
}
