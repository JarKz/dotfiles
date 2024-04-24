local home = os.getenv("HOME")
local java_ext = os.getenv("JAVA_EXTENSIONS")

local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local java_previews = require("extensions.java.previews")
require("extensions.java.jdtls_pickers")

function Set(list)
  local set = {}
  for _, value in ipairs(list) do
    set[value] = true
  end
  return set
end

local ignore_tasks = Set({
  "Validate documents",
  "Publish Diagnostics",
  "Building",
})

require("fidget").progress.options.display.format_message = function(msg)
  if ignore_tasks[msg.title] then
    return nil
  end
  if msg.message then
    return msg.message
  else
    return msg.done and "Completed" or "In progres..."
  end
end

local on_attach = function(client, bufnr)
  require("jdtls.setup").add_commands()
  jdtls.setup_dap({ hotcodereplace = "auto" })
  jdtls.jol_path = ""

  require("lspkind").init()

  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local mapping_options = {
    mode = "n",
    prefix = "<leader>",
    buffer = bufnr,
    silent = true,
    noremap = true,
    nowait = false,
  }

  local java_functions = {
    name = "Java Tools",
    o = { jdtls.organize_imports, "Organize imports" },
    c = {
      name = "Compile",
      f = {
        function()
          jdtls.compile("full")
        end,
        "Full compile",
      },
      i = {
        function()
          jdtls.compile("incremental")
        end,
        "Incremental compile",
      },
    },
    b = { jdtls.build_projects, "Build projects" },
    u = { jdtls.update_projects_confis, "Update projects config" },
    e = {
      name = "Extract",
      c = { jdtls.extract_constant, "Constant" },
      v = { jdtls.extract_variable, "Variable" },
      m = { jdtls.extract_method, "Method" },
    },
    j = { jdtls.javap, "Javap" },
    s = { jdtls.jshell, "JShell" },
    t = {
      name = "Test",
      c = { jdtls.test_class, "Class" },
      m = { jdtls.test_nearest_method, "Nearest method" },
    },
    p = {
      name = "Preview",
      e = { java_previews.enable, "Enable" },
      d = { java_previews.disable, "Disable" },
    },
  }

  local mapping = {
    d = {
      s = {
        function()
          jdtls_setup.wipe_data_and_restart()
          require("jdtls.dap").setup_dap_main_class_configs()
        end,
        "Java setup debug",
      },
    },
    j = java_functions,
  }

  local wk = require("which-key")
  wk.register(mapping, mapping_options)

  local visual_mapping_options = mapping_options
  visual_mapping_options.mode = "v"
  local visual_mapping = {
    j = {
      name = "Java in visual mode",
      e = {
        name = "Extract",
        v = {
          function()
            jdtls.extract_variable(true)
          end,
          "Variables",
        },
        m = {
          function()
            jdtls.extract_method(true)
          end,
          "Methods",
        },
      },
    },
  }
  wk.register(visual_mapping, visual_mapping_options)

  vim.cmd([[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      ]])
  local lsp_document_highlight_group = vim.api.nvim_create_augroup("LsdDocumentHighlight", { clear = false })

  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    group = lsp_document_highlight_group,
    buffer = 0,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    group = lsp_document_highlight_group,
    buffer = 0,
    callback = function()
      vim.lsp.buf.clear_references(0)
    end,
  })
end

local root_markers = { "gradlew", "pom.xml" }
local root_dir = jdtls_setup.find_root(root_markers)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_folder = home .. "/Coding/javaProjects/jdtlsWorkspaces/" .. project_name
local config = {
  flags = {
    allow_incremental_sync = true,
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

config.root_dir = root_dir

config.settings = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    filteredTypes = {
      "com.sun.*",
      "io.micrometer.shaded.*",
      "java.awt.*",
      "jdk.*",
      "sun.*",
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    implementationsCodeLens = {
      enabled = true,
    },
    referencesCodeLens = {
      enabled = true,
    },
    codeGeneration = {
      hashCodeEquals = {
        useInstanceof = true,
        useJava7Objects = true,
      },
      toString = {
        template = "${object.className}[${member.name()}=${member.value}, ${otherMembers}]",
        codeStyle = "STRING_BUILDER_CHAINED",
      },
    },
    configuration = {
      runtimes = {
        {
          name = "JavaSE-17",
          path = os.getenv("JAVA_HOME"),
          default = true,
        },
        {
          name = "JavaSE-21",
          path = os.getenv("JAVA_LATEST_HOME"),
        },
        {
          name = "JavaSE-11",
          path = os.getenv("JAVA_11_HOME"),
        },
        {
          name = "JavaSE-1.8",
          path = os.getenv("JAVA_8_HOME"),
        },
      },
    },
  },
}

config.cmd = {
  os.getenv("JAVA_HOME") .. "/bin/java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xmx1g",
  "-jar",
  vim.fn.glob(
    java_ext
    .. "/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar",
    true
  ),
  "-configuration",
  java_ext .. "/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac",
  "-data",
  workspace_folder,
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",
}

config.on_attach = on_attach
config.on_init = function(client, _)
  client.notify("workspace/didChangeConfiguration", { settings = config.settings })
end

local jar_patterns = {
  java_ext .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
  java_ext .. "/vscode-java-test/server/*.jar",
}

local bundles = {}
for _, jar_pattern in ipairs(jar_patterns) do
  for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
    if
        not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
        and not vim.endswith(bundle, "com.microsoft.java.test.runner.jar")
    then
      table.insert(bundles, bundle)
    end
  end
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
config.init_options = {
  bundles = bundles,
  extendedClientCapabilities = extendedClientCapabilities,
}

config.handlers = {}
config.handlers["language/status"] = function() end
jdtls.start_or_attach(config)
