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
