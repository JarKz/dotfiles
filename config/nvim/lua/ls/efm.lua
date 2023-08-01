local M = {}

function M.setup()
    require("lspconfig").efm.setup({
        init_options = { documentFormatting = true },
        cmd = { "efm-langserver", "-c=" .. os.getenv("XDG_CONFIG_HOME") .. "/efm-langserver/config.yaml" },
        filetypes = {
            "java",
            "markdown",
            "json",
            "json5",
            "text",
            "help",
            "cpp",
            "c",
            "sh",
            "bash",
            "zsh",
            "yaml",
            "javascript",
            "typescript",
            "css",
            "scss",
            "sass",
            "less",
            "sugarss",
            "html",
            "xml",
        },
    })
end

return M
