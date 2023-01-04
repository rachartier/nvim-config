require('dap.ext.vscode').load_launchjs()
require("nvim-dap-virtual-text").setup()
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='❯'} )
