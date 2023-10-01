return {
  -- "echasnovski/mini.indentscope",
  -- version = "*",
  -- enabled = false,
  -- config = function()
  --   require("mini.indentscope").setup({
  --     symbol = "│",
  --     draw = {
  --       -- Delay (in ms) between event and start of drawing scope indicator
  --       delay = 100,
  --
  --       -- Animation rule for scope's first drawing. A function which, given
  --       -- next and total step numbers, returns wait time (in ms). See
  --       -- |MiniIndentscope.gen_animation| for builtin options. To disable
  --       -- animation, use `require('mini.indentscope').gen_animation.none()`.
  --       -- animation = --<function: implements constant 20ms between steps>,
  --
  --       -- Symbol priority. Increase to display on top of more symbols.
  --       priority = 2,
  --     },
  --   })
  -- end,

  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    require("ibl").setup({
      char = "│",
      show_trailing_blankline_indent = false,
      show_current_context = true,
      use_treesitter = true,
      show_first_indent_level = true,

      -- show_trailing_blankline_indent = false,
      -- show_current_context = true,
      -- show_first_indent_level = true,
      -- use_treesitter = true,
    })
  end,
}
