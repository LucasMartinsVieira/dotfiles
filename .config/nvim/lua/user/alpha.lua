local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl_shortcut = "Macro"
  return b
end

dashboard.section.header.val = {
[[  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
[[  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
[[  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
[[  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
[[  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
[[  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}
dashboard.section.buttons.val = {
        button("SPC f f", "  Find file", "<CMD>Telescope file_browser<CR>"),
        button("SPC f e", "  New file", "<cmd>ene!<CR>"),
        button("SPC f w", "  Find word", "<CMD>Telescope live_grep<CR>"),
        button("SPC f r", "  Recent Files", "<CMD>Telescope oldfiles<CR>"),
        button("SPC f p", "  Recent Projects", "<CMD>Telescope projects<CR>"),
        button("SPC m", "  Vim Wiki", ":VimwikiIndex<CR>"),
        button("SPC c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
        button("SPC u", "  Update", ":PackerSync<CR>"),
        button("SPC q", "  Quit", ":q<CR>"),
}
local function footer()
  return "https://github.com/LucasMartinsVieira"
end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Macro"
dashboard.section.footer.opts.hl = "Type"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
