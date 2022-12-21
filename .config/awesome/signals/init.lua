req = {
  "volume",
  "updates"
}

for _, x in pairs(req) do
  require("signals."..x)
end
