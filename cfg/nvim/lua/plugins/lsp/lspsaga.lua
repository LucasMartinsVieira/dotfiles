return {
  -- Better UI for LSP
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  enabled = true,
  config = function()
    -- Calling setup for lspsaga
    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
    })
    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end

      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("gl", "<CMD>Lspsaga show_line_diagnostics<CR>", "Open floating Diagnostic")
    nmap("[d", "<CMD>Lspsaga diagnostic_jump_prev<CR>", "Goto Previous Diagnostic")
    nmap("]d", "<CMD>Lspsaga diagnostic_jump_next<CR>", "Goto Next Diagnostic")
    nmap("<leader>la", "<CMD>Lspsaga code_action<CR>", "Code Action")
  end,
}
