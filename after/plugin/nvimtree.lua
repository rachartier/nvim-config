require("nvim-tree").setup()

vim.keymap.set("n", "<leader>te", "<cmd>NvimTreeToggle<CR>", { silent = true })
