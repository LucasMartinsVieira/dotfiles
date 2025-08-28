local status_ok_mini_surround, mini_surround = pcall(require, "mini.surround")
if not status_ok_mini_surround then
	vim.notify("mini surround plugin not found!", vim.log.levels.ERROR)
	return
end

mini_surround.setup()

local status_ok_mini_pairs, mini_pairs = pcall(require, "mini.pairs")
if not status_ok_mini_pairs then
	vim.notify("mini pairs plugin not found!", vim.log.levels.ERROR)
	return
end

mini_pairs.setup()

local status_ok_mini_ai, mini_ai = pcall(require, "mini.ai")
if not status_ok_mini_ai then
	vim.notify("mini ai plugin not found!", vim.log.levels.ERROR)
	return
end

mini_ai.setup()

local status_ok_mini_statusline, mini_statusline = pcall(require, "mini.statusline")
if not status_ok_mini_statusline then
	vim.notify("mini statusline plugin not found!", vim.log.levels.ERROR)
	return
end

mini_statusline.setup()
