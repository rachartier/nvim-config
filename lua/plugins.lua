-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-dap.nvim'
        }
    },
    {
        'navarasu/onedark.nvim',
        as = "onedark",
    },
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
    {'nvim-treesitter/playground'},
    {'theprimeagen/harpoon'},
    {'mbbill/undotree'},
    {'tpope/vim-fugitive'},
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        }
    },
    {"folke/zen-mode.nvim"},
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },

    },
    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        }
    },
    {
        "folke/trouble.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons"
        }
    },

    {'kdheepak/lazygit.nvim'},
    {'onsails/lspkind.nvim'},
    {'lukas-reineke/indent-blankline.nvim'},
    {
        'kosayoda/nvim-lightbulb',
        dependencies = 'antoinemadec/FixCursorHold.nvim',
    },

    {'mfussenegger/nvim-jdtls'},
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    },
    {'mfussenegger/nvim-dap'},
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    },
    {'theHamsta/nvim-dap-virtual-text'},
    {'https://codeberg.org/esensar/nvim-dev-container'},
    {'jamestthompson3/nvim-remote-containers'},
    {"folke/twilight.nvim"},
    {"luukvbaal/statuscol.nvim"},
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
})

