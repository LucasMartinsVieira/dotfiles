return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("gl", "<CMD>Lspsaga show_line_diagnostics<CR>", "Open floating Diagnostic")
    nmap("[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", "Open Previous Diagnostic")
    nmap("]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", "Open Next Diagnostic")
    nmap("<leader>la", "<CMD>Lspsaga code_action<CR>", "Code Action")

    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
        sign = false,
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
