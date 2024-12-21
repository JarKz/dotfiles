require "lspconfig".clangd.setup {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
  cmd = {
    "/usr/bin/clangd",
    "--offset-encoding=utf-16"
  }
}
