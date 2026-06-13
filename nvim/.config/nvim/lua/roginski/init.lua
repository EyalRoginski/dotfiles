require("roginski.remap")
require("roginski.set")
require("roginski.autocmd")

vim.api.nvim_create_autocmd({ "VimLeave" }, {
    pattern = { "*" },
    command = "set guicursor=a:ver100"
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("kanagawa")
        end
    },
    -- {
    --     'nvim-treesitter/nvim-treesitter',
    --     build = ':TSUpdate',
    --     config = function()
    --         require('nvim-treesitter.configs').setup({
    --             ensure_installed = { "python", "rust", "javascript", "java", "html", "c", "lua", "vim", "vimdoc", "query" },
    --             sync_install = false,
    --             auto_install = true,
    --             highlight = {
    --                 enable = true,
    --                 additional_vim_regex_highlighting = false,
    --             },
    --         })
    --     end
    -- },
    { 'williamboman/mason.nvim' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'tpope/vim-surround' },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    { 'abecodes/tabout.nvim' },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        'numToStr/Comment.nvim',
        opts = {}
    },
})
