local gears = require("gears")

-- Create rounded rectangle shape (in one line)
local helpers = {}

helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

-- function to colorize text
function helpers.colorize_text(txt, fg)
    return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

return helpers
