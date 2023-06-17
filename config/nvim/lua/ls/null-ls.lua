local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Java
		null_ls.builtins.formatting.google_java_format.with({
			args = { "--aosp" },
		}),
		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Bash
		null_ls.builtins.code_actions.shellcheck,

		-- HTML
		null_ls.builtins.formatting.htmlbeautifier,
		null_ls.builtins.diagnostics.tidy,

		-- JS(X)/TS(X)
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.eslint_d,

		-- Spell
		null_ls.builtins.completion.spell,
		null_ls.builtins.diagnostics.codespell,
		null_ls.builtins.diagnostics.misspell,
		-- null_ls.builtins.diagnostics.todo_comments,

		-- Git
		null_ls.builtins.diagnostics.commitlint.with({
			args = {
				"-g",
				vim.fn.expand(vim.fn.getenv("XDG_CONFIG_HOME") .. "/nvim/language_servers/commitlintrc.js"),
				"-x",
				"/opt/homebrew/lib/node_modules/@commitlint/config-conventional",
				"--format",
				"commitlint-format-json",
			},
		}),

		-- Protobuf
		-- null_ls.builtins.diagnostics.protoc_gen_lint,
		-- null_ls.builtins.diagnostics.protolint

		-- Yaml
		null_ls.builtins.diagnostics.yamllint,

		-- Postgres (currently not available from Mason)
		-- null_ls.builtins.formatting.pg_format,
	},
})
