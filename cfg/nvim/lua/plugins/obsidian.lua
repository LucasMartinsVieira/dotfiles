local vault = os.getenv("HOME") .. "/Documents/obsidian"
local icons = require("user.icons")

if not vim.uv.fs_stat(vault) then
  return {}
end

return {
  {
    "obsidian-nvim/obsidian.nvim",
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
      "folke/snacks.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      workspaces = {
        {
          name = "obsidian",
          path = vault,
        },
      },
      ui = {
        enable = false,
      },
      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = true,
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      picker = {
        completion = {
          -- Enables completion using nvim_cmp
          nvim_cmp = false,
          -- Enables completion using blink.cmp
          blink = true,
          -- Trigger completion at 2 chars.
          min_chars = 2,
        },
        picker = {
          name = "snacks.picker",
          note_mappings = {
            -- Create a new note from your query.
            new = "<C-x>",
            -- Insert a link to the selected note.
            insert_link = "<C-l>",
          },
          tag_mappings = {
            -- Add tag(s) to current note.
            tag_note = "<C-x>",
            -- Insert a tag at the current location.
            insert_tag = "<C-l>",
          },
        },
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
  },
}
