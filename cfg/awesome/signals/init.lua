req = {
  "volume",
  "updates",
  "wifi",
  "disk",
  "uptime",
  "battery"
}

for _, x in pairs(req) do
  require("signals."..x)
end
