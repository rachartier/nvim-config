

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/rachartier/.cache/workspace-root/' .. project_name

local config = {
    cmd = {
        'java', -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar', '/opt/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version


        -- 💀
        '-configuration', '/opt/jdtls/config_linux/',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.


        -- 💀
        -- See `data directory configuration` section in the README
        '-data', workspace_dir
    },
    settings = {
        java = {
            signatureHelp = { enabled = true },
            configuration = {
                updateBuildConfiguration = "interactive",
                eclipse = {
                    downloadSources = true,
                },
                maven = {
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    enabled = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                references = {
                    includeDecompiledSources = true,
                },
                inlayHints = {
                    parameterNames = {
                        enabled = "all", -- literals, all, none
                    },
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
            },
        },
        root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    }
}

config["on_attach"] = function(client, bufnr)
	local _, _ = pcall(vim.lsp.codelens.refresh)
	-- require("jdtls.dap").setup_dap_main_class_configs()
	-- require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("rachartier").on_attach(client, bufnr)
	require("lvim.lsp").on_attach(client, bufnr)
end

require('jdtls').start_or_attach(config)

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.java",
    callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
        local params = vim.lsp.util.make_range_params()
        local bufnr = vim.api.nvim_get_current_buf()
        params.context = {
            diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
        }
        local result, err = vim.lsp.buf_request_sync(0, "java/organizeImports", params)

        if err then
            print("Error on organize imports: " .. err)
            return
        end

        result = vim.tbl_values(result)
        if result and result[1].result then
            vim.lsp.util.apply_workspace_edit(result[1].result, "utf-16")
        end
    end,
})
