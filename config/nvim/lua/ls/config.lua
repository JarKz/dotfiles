local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

lsp_defaults.capabilities =
	vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

local servers = {
	"pyright",
	"gradle_ls",
	"groovyls",
	"tsserver",
	"cssls",
	"html",
	"bashls",
	"rust_analyzer",
	"kotlin_language_server"
}
for _, server in ipairs(servers) do
	lspconfig[server].setup({})
end

local mapping_options = {
	mode = "n",
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local mapping = {
	["<space>"] = {
		name = "Special",
		e = { vim.diagnostic.open_float, "Open diagnostic window" },
		q = { vim.diagnostic.setloclist, "List of diagnostics" },
	},
	["]"] = {
		d = { vim.diagnostic.goto_next, "Next diagnostic" },
	},
	["["] = {
		d = { vim.diagnostic.goto_Prev, "Previous diagnostic" },
	},
}

local wk = require("which-key")
wk.register(mapping, mapping_options)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local lsp_mapping_options = {
			mode = "n",
			prefix = "",
			buffer = ev.buf,
			silent = true,
			noremap = true,
			nowait = false,
		}

		local lsp_mapping = {
			["<space>"] = {
				name = "Special",
				w = {
					name = "Workspace",
					a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
					r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
					l = {
						function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end,
						"List of workspace folders",
					},
				},
				D = { vim.lsp.buf.type_definition, "Type definition" },
				r = {
					name = "Rename -> prefix",
					n = { vim.lsp.buf.rename, "Rename" },
				},
				c = {
					name = "Code action -> prefix",
					a = { vim.lsp.buf.code_action, "Code action" },
				},
				f = {
					function()
						vim.lsp.buf.format({ async = true })
					end,
					"Format",
				},
				K = {
					function()
						local winid = require("ufo").peekFoldedLinesUnderCursor()
						if not winid then
							vim.lsp.buf.hover()
						end
					end,
					"Hower (show documentation or show fold preview)",
				},
			},
			g = {
				name = "Global function",
				D = { vim.lsp.buf.declaration, "Declaration" },
				d = { vim.lsp.buf.definition, "Definition" },
			},
			["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help" },
			["<leader>"] = {
				name = "Leader functions",
				R = { vim.lsp.buf.references , "References" },
				I = { vim.lsp.buf.implementation, "Implementations" }
			}
		}
		wk.register(lsp_mapping, lsp_mapping_options)
	end,
})
