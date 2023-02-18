return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	},
	cmd = { "NvimTreeToggle" },
	keys = {
		{ "<space>e", "<CMD>NvimTreeToggle<CR>", desc = "File Manager" },
	},

	config = function()
		require("nvim-tree").setup({
			disable_netrw = true,
			hijack_netrw = true,
			--ignore_ft_on_setup = { "startify", "dashboard", "alpha" },
			auto_reload_on_write = true,
			open_on_tab = false,
			hijack_cursor = false,
			update_cwd = true,
			hijack_unnamed_buffer_when_opening = false,
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			diagnostics = {
				enable = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
				ignore_list = {},
			},
			system_open = {
				cmd = nil,
				args = {},
			},
			filters = {
				dotfiles = false,
				custom = {},
			},
			git = {
				enable = true,
				ignore = true,
				timeout = 500,
			},
			view = {
				width = 30,
				hide_root_folder = false,
				side = "left",
				preserve_window_proportions = false,
				mappings = {
					custom_only = false,
					list = {
            { key = "l", action = "open" },
            { key = "v", action = "vsplit" },
					},
				},
				number = false,
				relativenumber = false,
				signcolumn = "yes",
			},
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
			actions = {
				change_dir = {
					enable = true,
					global = false,
				},
				open_file = {
					quit_on_open = true,
					resize_window = true,
					window_picker = {
						enable = true,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = {
								"notify",
								"packer",
								"qf",
							},
						},
					},
				},
			},
			renderer = {
				root_folder_modifier = ":t",
				icons = {
					webdev_colors = true,
					git_placement = "before",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						default = "",
						symlink = "",
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							deleted = "",
							untracked = "U",
							ignored = "◌",
						},
						folder = {
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
						},
					},
				},
			},
		})
	end,
}
