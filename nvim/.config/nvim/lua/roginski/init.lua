require("roginski.remap")
require("roginski.set")
require("roginski.autocmd")

vim.api.nvim_create_autocmd({ "VimLeave" }, {
    pattern = { "*" },
    command = "set guicursor=a:ver100"
})

local godot_pipe = "/tmp/godot.pipe"
if vim.fn.filereadable(godot_pipe) == 0 then
    vim.fn.serverstart(godot_pipe)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

local is_portable = vim.env.NVIM_PORTABLE == "1"

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
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
    {
        "romus204/tree-sitter-manager.nvim",
        dependencies = {},
        config = function()
            require("tree-sitter-manager").setup({
                ensure_installed = { "rust", "c", "cpp", "python", "gdscript", "markdown", "markdown_inline", "lua", "vimdoc", "toml", "bash", "awk", "c_sharp", "nix" }
            })
        end
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    { 'tpope/vim-surround' },
    { 'lewis6991/gitsigns.nvim' },
    { 'abecodes/tabout.nvim' },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    { 'neovim/nvim-lspconfig' },
    { 'folke/which-key.nvim' },
    {
        'stevearc/oil.nvim',
        lazy = false,
        opts = {
            -- <C-s> is the tmux prefix, so it can't reach Neovim
            keymaps = {
                ["<C-s>"] = false,
                ["<C-v>"] = { "actions.select", opts = { vertical = true } },
            },
            view_options = { show_hidden = true },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            local context = require('treesitter-context')
            context.setup({ max_lines = 4 })
            vim.keymap.set('n', '<leader>uc', context.toggle, { desc = "Toggle code context" })
        end,
    },
    {
        'tamton-aquib/duck.nvim',
        keys = {
            { '<leader>qq', function() require('duck').hatch() end,    desc = "Hatch a duck" },
            { '<leader>qk', function() require('duck').cook() end,     desc = "Cook a duck" },
            { '<leader>qa', function() require('duck').cook_all() end, desc = "Cook all ducks" },
        },
    },
}, {
    checker = {
        enabled = not is_portable,
    },

    change_detection = {
        enabled = not is_portable,
        notify = not is_portable,
    },
})
