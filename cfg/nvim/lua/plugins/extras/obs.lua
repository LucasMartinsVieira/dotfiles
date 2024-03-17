local vault = os.getenv("HOME") .. "/Documents/obsidian"

return {
  "IlyasYOY/obs.nvim",
  dependencies = {
    "IlyasYOY/coredor.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  ft = "markdown",
  keys = {
    { "<leader>sf", "<CMD>ObsNvimFollowLink<CR>", desc = "Follow Link" },
    { "<leader>sb", "<CMD>ObsNvimBackLinks<CR>", desc = "Back Links" },
    { "<leader>sC", "<CMD>ObsNvimCopyObsidianLinkToNote<CR>", desc = "Copy Obsidian Link to Note" },
    { "<leader>sm", "<CMD>ObsNvimMove<CR>", desc = "Move Note" },
    { "<leader>sR", "<CMD>ObsNvimRandomNote<CR>", desc = "Open Random Note" },
    { "<leader>sr", "<CMD>ObsNvimRename<CR>", desc = "Rename" },
  },
  config = function()
    require("obs").setup({
      vault_home = vault,
      vault_name = "obsidian",
      journal = {
        template_name = "Daily Note Template",
      },
    })

    -- config for nvim-cmp
    local cmp = require("cmp")
    local cmp_source = require("obs.cmp-source")
    cmp.register_source("obs", cmp_source.new())

    -- config for obs.nvim
    local group = vim.api.nvim_create_augroup("ObsNvim", { clear = true })
    local obs = require("obs")

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      group = group,
      pattern = "*.md",
      desc = "Setup notes nvim-cmp source",
      callback = function()
        if obs.vault:is_current_buffer_in_vault() then
          require("cmp").setup.buffer({
            sources = {
              { name = "obs" },
              { name = "emoji" },
              { name = "luasnip" },
            },
          })
        end
      end,
    })
  end,
}
