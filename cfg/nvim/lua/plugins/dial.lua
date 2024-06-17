return {
  "monaqa/dial.nvim",
  enabled = true,
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
      },
      visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
      },
      mygroup = {
        augend.constant.new({
          elements = { "public", "private", "protected" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "let", "const" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        }),
        augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
        augend.constant.alias.bool, -- boolean value (true <-> false)
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.semver.alias.semver,
      },
    })

    local map = require("dial.map")

    -- change augends in VISUAL mode
    vim.api.nvim_set_keymap("n", "<C-a>", map.inc_normal("mygroup"), { noremap = true })
    vim.api.nvim_set_keymap("n", "<C-x>", map.dec_normal("mygroup"), { noremap = true })
    vim.api.nvim_set_keymap("v", "<C-a>", map.inc_normal("visual"), { noremap = true })
    vim.api.nvim_set_keymap("v", "<C-x>", map.dec_normal("visual"), { noremap = true })
  end,
}
