require('neural').setup({
    source = {
        openai = {
            api_key = vim.env.OPENAI_API_KEY,
        },
    },
})

vim.keymap.set("n", "<leader>n", "<cmd>Neural<cr>", { silent = true })
