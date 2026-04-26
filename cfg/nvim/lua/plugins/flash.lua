return {
	"folke/flash.nvim",
	enabled = "false",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {},
	keys = {
    -- stylua: ignore
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- stylua: ignore
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- stylua: ignore
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- stylua: ignore
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- stylua: ignore
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}
