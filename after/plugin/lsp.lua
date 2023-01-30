local lsp = require("lsp-zero")
lsp.preset("recommended")

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end


local on_attach = function(client, bufnr)
    local bufopts = {buffer = bufnr, remap = false}

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition,bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover,bufopts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol,bufopts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float,bufopts)
    vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next,bufopts)
    vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev,bufopts)
    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,bufopts)
    vim.keymap.set("n", "<leader>ca", "<cmd>CodeActionMenu<cr>",bufopts)
    vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references,bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,bufopts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help,bufopts)


    function nnoremap(rhs, lhs, desc, bufopts)
        bufopts.desc = desc
        vim.keymap.set("n", rhs, lhs, bufopts)
    end


    -- nvim-dap
    nnoremap("<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Set breakpoint", bufopts)
    nnoremap("<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Set conditional breakpoint", bufopts)
    nnoremap("<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Set log point", bufopts)
    nnoremap('<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints", bufopts)
    nnoremap('<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', "List breakpoints", bufopts)

    nnoremap("<F5>", "<cmd>lua require'dap'.continue()<cr>", "Continue", bufopts)
    nnoremap("<F10>", "<cmd>lua require'dap'.step_over()<cr>", "Step over", bufopts)
    nnoremap("<F11>", "<cmd>lua require'dap'.step_into()<cr>", "Step into", bufopts)
    nnoremap("<S-F11>", "<cmd>lua require'dap'.step_out()<cr>", "Step out", bufopts)
    nnoremap('<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect", bufopts)
    nnoremap('<leader>dt', "<cmd>lua require'dap'.terminate()<cr>", "Terminate", bufopts)
    nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Open REPL", bufopts)
    nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Run last", bufopts)
    nnoremap('<leader>di', function() require"dap.ui.widgets".hover() end, "Variables", bufopts)
    nnoremap('<leader>ds', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end, "Scopes", bufopts)
    nnoremap('<leader>df', '<cmd>Telescope dap frames<cr>', "List frames", bufopts)
    nnoremap('<leader>dh', '<cmd>Telescope dap commands<cr>', "List commands", bufopts)

    require 'illuminate'.on_attach(client)
end


local _start_client = vim.lsp.start_client
vim.lsp.start_client = function(config)
    if config.on_attach == nil then
        config.on_attach = on_attach
    else
        local _on_attach = config.on_attach
        config.on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            _on_attach(client, bufnr)
        end
    end
    return _start_client(config)
end

lsp.setup()

vim.diagnostic.config({
    virtual_text = { prefix = "●" },
    -- show signs
    signs = {
        active = signs,
    },
})


local lspkind = require('lspkind')
cmp.setup {
    completion = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        scrollbar = "║"
    },
    formatting = {
        fields = {
            cmp.ItemField.Kind,
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu,
        },
        format = lspkind.cmp_format({
            with_text = false,
            before = function(entry, vim_item)
                return vim_item
            end,
        }),
    },
}


require("cmp").setup.cmdline(":", {
    sources = {
        { name = "cmdline", keyword_length = 2 },
    },
})


local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'
local capabilities = require('cmp_nvim_lsp').default_capabilities()


local path = util.path

local function get_python_path(workspace)
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
    end

    -- Find and use virtualenv in workspace directory.
    for _, pattern in ipairs({'*', '.*'}) do
        local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
        if match ~= '' then
            return path.join(path.dirname(match), 'bin', 'python')
        end
    end

    -- Fallback to system Python.
    return exepath('python3') or exepath('python') or 'python'
end


-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
    before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path(config.root_dir)
    end,
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = util.root_pattern('pyrightconfig.json')
}

require('lspconfig')['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['bashls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['jsonls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['vimls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

