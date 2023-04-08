req = {
  "volume",
  "updates",
  "wifi",
  "disk",
  "uptime",
  "battery",
  "dnd",
  "bluetooth"
}

for _, x in pairs(req) do
  require("signals."..x)
end
