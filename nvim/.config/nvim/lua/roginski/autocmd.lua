vim.api.nvim_create_autocmd({ "BufEnter", "WinClosed", "WinNew" }, {
    pattern = "*",
    callback = function()
        vim.fn.system({ "tmux", "rename-window", vim.fn.expand("%:t") })
    end
})
vim.api.nvim_create_autocmd({ "VimLeave" }, {
    pattern = "*",
    callback = function()
        vim.fn.system({ "tmux", "rename-window", "zsh" })
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    end,
})
