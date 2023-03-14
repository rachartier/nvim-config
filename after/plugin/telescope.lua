require('telescope').load_extension('dap')
require('telescope').load_extension('vimwiki')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})

vim.keymap.set('n', '<leader>wg', require('telescope').extensions.vimwiki.live_grep, {})
vim.keymap.set('n', '<leader>wf', require('telescope').extensions.vimwiki.vimwiki, {})


