require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "frappe",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.05,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
      highlight_overrides = {
        all = function(colors)
            return {
                NvimTreeNormal = { fg = colors.none },
            }
       end,
    },
    integrations = {
        cmp = true,
        bufferline = false,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = false,
        harpoon = true,
        dap = true,
        lsp_trouble = true,
        mason = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})


require('catppuccin').load()
vim.cmd.colorscheme "catppuccin"

local colors = require("catppuccin.palettes").get_palette "macchiato"
local TelescopeColor = {
	TelescopeMatching = { fg = colors.flamingo },
	TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

	TelescopePromptPrefix = { bg = colors.surface0 },
	TelescopePromptNormal = { bg = colors.surface0},
	TelescopeResultsNormal = { bg = colors.mantle },
	TelescopePreviewNormal = { bg = colors.mantle },
	TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
	TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
	TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
	TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
	TelescopeResultsTitle = { fg = colors.mantle },
	TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
}

for hl, col in pairs(TelescopeColor) do
	vim.api.nvim_set_hl(0, hl, col)
end

vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]

--require('onedark').setup  {
--    -- Main options --
--    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--    transparent = false,  -- Show/hide background
--    term_colors = true, -- Change terminal color as per the selected theme style
--    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
--    -- toggle theme style ---
--    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
--    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between
--
--    -- Change code style ---
--    -- Options are italic, bold, underline, none
--    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
--    code_style = {
--        -- comments = 'italic',
--        comments = 'none',
--        keywords = 'none',
--        functions = 'none',
--        strings = 'none',
--        variables = 'none'
--    },
--
--    -- Lualine options --
--    lualine = {
--        transparent = false, -- lualine center bar transparency
--    },
--
--    -- Custom Highlights --
--    colors = {}, -- Override default colors
--    highlights = {}, -- Override highlight groups
--
--    -- Plugins Config --
--    diagnostics = {
--        darker = true, -- darker colors for diagnostic
--        undercurl = true,   -- use undercurl instead of underline for diagnostics
--        background = true,    -- use background color for virtual text
--    },
--}
--
--require('onedark').load()
--vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
