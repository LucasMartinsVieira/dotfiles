req = {
  "volume",
  "updates",
  "wifi",
  "disk",
  "uptime",
  "battery",
  "dnd"
}

for _, x in pairs(req) do
  require("signals."..x)
end
