return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					-- Enable treesitter highlighting and disable regex syntax
					pcall(vim.treesitter.start)
					-- Enable treesitter-based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			local ensure_installed = {
				"bash",
				"comment",
				"regex",
				"c",
				"html",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"lua",
				"markdown",
				"rust",
				"vim",
				"vimdoc",
				"yaml",
			}

			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(ensure_installed)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			require("nvim-treesitter").install(parsersToInstall)
		end,
		lazy = false,
		-- opts = {
		-- highlight = {
		-- 	enable = true,
		-- 	additional_vim_regex_highlighting = false,
		-- },
		-- folds = { enable = true },
		-- -- indent = {
		-- -- 	enable = true,
		-- -- },
		-- ensure_installed = {
		-- 	"bash",
		-- 	"comment",
		-- 	"regex",
		-- 	"c",
		-- 	"html",
		-- 	"javascript",
		-- 	"typescript",
		-- 	"tsx",
		-- 	"json",
		-- 	"lua",
		-- 	"markdown",
		-- 	"rust",
		-- 	"vim",
		-- 	"vimdoc",
		-- 	"yaml",
		-- },
		-- auto_install = false,
		-- },
	},
	{
		"folke/ts-comments.nvim",
		opts = {
			lang = {
				tsx = {
					"// %s", -- default commentstring when no treesitter node matches
					"/* %s */",
					call_expression = "// %s", -- specific commentstring for call_expression
					jsx_attribute = "// %s",
					jsx_element = "{/* %s */}",
					jsx_fragment = "{/* %s */}",
					spread_element = "// %s",
					statement_block = "// %s",
				},
			},
		},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
}
