req = {
  "volume",
  "updates",
  "wifi",
  "player",
  "disk",
  "battery"
}

for _, x in pairs(req) do
  require("signals."..x)
end
