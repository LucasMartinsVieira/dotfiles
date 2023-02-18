return {
	"goolord/alpha-nvim",
	
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		local function button(sc, txt, keybind, keybind_opts)
			local b = dashboard.button(sc, txt, keybind, keybind_opts)
			b.opts.hl_shortcut = "Macro"
			return b
		end

		-- dashboard.section.header.val = {
		-- [[  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
		-- [[  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
		-- [[  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
		-- [[  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
		-- [[  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
		-- [[  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
		-- }

 dashboard.section.header.val = {
            [[                                                                       ]],
            [[  ██████   █████                   █████   █████  ███                  ]],
            [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
            [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
            [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
            [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
            [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
            [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
            [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
            [[                                                                       ]],
        }
		-- dashboard.section.header.val = {
		-- 	[[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ]],
		-- 	[[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
		-- 	[[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ]],
		-- 	[[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
		-- 	[[          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
		-- 	[[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
		-- 	[[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
		-- 	[[ ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
		-- 	[[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ]],
		-- 	[[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
		-- 	[[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
		-- }

		dashboard.section.buttons.val = {
			button("f", "  Find file", "<CMD>Telescope find_files<CR>"),
			button("n", "  New file", "<CMD>ene!<BAR>startinsert<CR>"),
			button("e", "  File Tree", "<CMD>NvimTreeToggle<CR>"),
			button("c", "  Config", "<CMD>e ~/.config/nvim/init.lua<CR>"),
			button("u", "  Update", "<CMD>Lazy sync<CR>"),
			button("q", "  Quit", "<CMD>q<CR>"),
		}
		local function footer()
			return "https://github.com/LucasMartinsVieira"
		end

		dashboard.section.footer.val = footer()

		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Macro"
		dashboard.section.footer.opts.hl = "Type"

		dashboard.opts.opts.noautocmd = true
    return dashboard
	end,

  config = function(_, dashboard)
    require("alpha").setup(dashboard.opts)
  end
}
