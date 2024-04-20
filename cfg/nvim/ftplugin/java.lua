local jdtls_path = "/run/current-system/sw/bin/jdtls"

local config = {
  cmd = { jdtls_path },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
