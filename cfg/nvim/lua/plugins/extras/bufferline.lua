return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "v3.*",
  enabled = false,
  event = "VeryLazy",
  keys = {
    -- { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin", },
    -- { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    -- { "<leader>bN", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Next" },
    -- { "<leader>bP", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Prev" },
  },

  config = function()
    local icons = require("user.icons")
    require("bufferline").setup({
      options = {
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator = {
          icon = icons.ui.Separator,
          style = "icon",
        },
        buffer_close_icon = icons.ui.Close,
        modified_icon = icons.ui.Circle,
        close_icon = icons.ui.Close,
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 20,
        diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            padding = 1,
          },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    })
  end,
}
