req = {
  "volume",
  "updates",
  "wifi"
}

for _, x in pairs(req) do
  require("signals."..x)
end
