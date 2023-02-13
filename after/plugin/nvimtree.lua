local nvim_tree = require('nvim-tree')
local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = 60
local height = 20

nvim_tree.setup{
    view = {
        width = width,
        float = {
            enable = true,
            open_win_config = {
                relative = "editor",
                border = "rounded",
                width = width,
                height = height,
                row = (gheight - height) * 0.4,
                col = (gwidth - width) * 0.5,
            }
        }
    },
    renderer = {
        root_folder_label = function(path)
            return vim.fn.fnamemodify(path, ":t")
        end
    }
}

vim.keymap.set("n", "<leader>te", "<cmd>NvimTreeToggle<CR>", { silent = true })
