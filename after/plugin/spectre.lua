require('spectre').setup()

vim.keymap.set("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>")
vim.keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")

vim.keymap.set("n", "<leader>s", "<esc>:lua require('spectre').open_visual()<CR>")
vim.keymap.set("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>")
