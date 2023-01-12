req = {
  "volume",
  "updates",
  "wifi",
  "player"
}

for _, x in pairs(req) do
  require("signals."..x)
end
