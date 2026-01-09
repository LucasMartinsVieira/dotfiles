local vault = os.getenv("HOME") .. "/Documentos/obsidian"

if not vim.uv.fs_stat(vault) then
	return {}
end

require("obsidian").setup({
	workspaces = {
		{
			name = "obsidian",
			path = vault,
		},
	},

	legacy_commands = false,

	-- Alternatively - and for backwards compatibility - you can set 'dir' to a single path instead of
	-- 'workspaces'. For example:
	-- dir = "~/vaults/work",

	-- Optional, if you keep notes in a specific subdirectory of your vault.
	-- notes_subdir = "notes",

	-- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
	-- levels defined by "vim.log.levels.*".
	log_level = vim.log.levels.INFO,

	-- daily_notes = {
	-- 	-- Optional, if you keep daily notes in a separate directory.
	-- 	folder = "notes/dailies",
	-- 	-- Optional, if you want to change the date format for the ID of daily notes.
	-- 	date_format = "%Y-%m-%d",
	-- 	-- Optional, if you want to change the date format of the default alias of daily notes.
	-- 	alias_format = "%B %-d, %Y",
	-- 	-- Optional, default tags to add to each new daily note created.
	-- 	default_tags = { "daily-notes" },
	-- 	-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
	-- 	template = nil,
	-- },

	-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
	completion = {
		-- Enables completion using nvim_cmp
		nvim_cmp = false,
		-- Enables completion using blink.cmp
		blink = true,
		-- Trigger completion at 2 chars.
		min_chars = 2,
	},

	-- Where to put new notes. Valid options are
	--  * "current_dir" - put new notes in same directory as the current buffer.
	--  * "notes_subdir" - put new notes in the default notes subdirectory.
	-- new_notes_location = "notes_subdir",

	-- Either 'wiki' or 'markdown'.
	preferred_link_style = "wiki",

	-- Optional, boolean or a function that takes a filename and returns a boolean.
	-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
	-- disable_frontmatter = true,

	frontmatter = {
		enabled = false,
	},

	note_id_func = nil,

	picker = {
		-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
		name = "snacks.pick",
		-- Optional, configure key mappings for the picker. These are the defaults.
		-- Not all pickers support all mappings.
		note_mappings = {
			-- Create a new note from your query.
			new = "<C-x>",
			-- Insert a link to the selected note.
			insert_link = "<C-l>",
		},
		tag_mappings = {
			-- Add tag(s) to current note.
			tag_note = "<C-x>",
			-- Insert a tag at the current location.
			insert_tag = "<C-l>",
		},
	},

	-- Optional, sort search results by "path", "modified", "accessed", or "created".
	-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
	-- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
	search = {
		sort_by = "modified",
		sort_reversed = true,
		max_lines = 1000,
	},

	-- Set the maximum number of lines to read from notes on disk when performing certain searches.

	-- Optional, determines how certain commands open notes. The valid options are:
	-- 1. "current" (the default) - to always open in the current window
	-- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
	-- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
	open_notes_in = "current",

	-- Optional, configure additional syntax highlighting / extmarks.
	-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
	ui = {
		enable = false, -- set to false to disable all additional syntax features
	},

	callbacks = {
		-- enter_note = function(note)
		-- 	vim.keymap.set("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", {
		-- 		buffer = true,
		-- 		desc = "Toggle checkbox",
		-- 	})
		-- end,
	},
})
