require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.7,
        width = 0.7,
    },
})

-- Example keybindings
vim.keymap.set('n', '<leader>t', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<leader>t', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
