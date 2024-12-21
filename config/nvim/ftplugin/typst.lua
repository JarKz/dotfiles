local lspconfig = require("lspconfig")

lspconfig.typst_lsp.setup {
  capabilities = require("blink.cmp").get_lsp_capabilities({
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }),
  settings = {
    exportPdf = "onSave" -- Choose onType, onSave or never.
  }
}
