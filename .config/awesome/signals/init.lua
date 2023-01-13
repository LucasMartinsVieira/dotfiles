req = {
  "volume",
  "updates",
  "wifi",
  "player",
  "disk"
}

for _, x in pairs(req) do
  require("signals."..x)
end
