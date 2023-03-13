require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.7,
        width = 0.7,
    },
})

-- Example keybindings
vim.keymap.set('n', '<leader>tg', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<leader>tg', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
