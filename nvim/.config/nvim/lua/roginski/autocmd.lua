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

-- Find python venv for LSPs
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        local function find_venv(path)
            local venv = path .. '/.venv'
            if vim.fn.isdirectory(venv) == 1 then
                return venv
            end
            local parent = vim.fn.fnamemodify(path, ':h')
            if parent == path then return nil end  -- reached filesystem root
            return find_venv(parent)
        end

        local file_dir = vim.fn.expand('%:p:h')
        local venv = find_venv(file_dir)
        if venv then
            vim.env.VIRTUAL_ENV = venv
            vim.env.PATH = venv .. '/bin:' .. vim.env.PATH
        end
    end,
})

-- Format on save
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local buf = event.buf  -- capture it here
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = buf,
            callback = function()
                local filetype = vim.bo[buf].filetype
                if filetype == 'python' then
                    vim.lsp.buf.format({ async = false, name = 'ruff' })
                else
                    vim.lsp.buf.format({ async = false })
                end
            end,
        })
    end,
})
