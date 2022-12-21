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


local opts = {buffer = bufnr, remap = false}

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

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




local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
}



