return {
  "echasnovski/mini.indentscope",
  version = "*",
  config = function()
    require("mini.indentscope").setup({
      symbol = "│",
      draw = {
        -- Delay (in ms) between event and start of drawing scope indicator
        delay = 100,

        -- Animation rule for scope's first drawing. A function which, given
        -- next and total step numbers, returns wait time (in ms). See
        -- |MiniIndentscope.gen_animation| for builtin options. To disable
        -- animation, use `require('mini.indentscope').gen_animation.none()`.
        -- animation = --<function: implements constant 20ms between steps>,

        -- Symbol priority. Increase to display on top of more symbols.
        priority = 2,
      },
    })
  end,
},

-- INFO: Disable mini.indentscope for the following file types:
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "NvimTree",
      "Trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
