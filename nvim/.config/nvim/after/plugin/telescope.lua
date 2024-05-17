local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fa', function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
        no_ignore_parent = true
    })
end, {})
vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fm', builtin.buffers, {})
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>la', builtin.lsp_dynamic_workspace_symbols, {})

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = "move_selection_next",
                ['<C-k>'] = "move_selection_previous",
            }
        }
    }
}
