-- Outside tmux, rename-window would target a window in some other session.
if vim.env.TMUX then
    vim.api.nvim_create_autocmd({ "BufEnter", "WinClosed", "WinNew" }, {
        pattern = "*",
        callback = function()
            -- Directory buffers like oil://path/ have no tail, so use the directory's name
            local name = vim.fn.expand("%:t")
            if name == "" then
                name = vim.fn.expand("%:h:t")
            end
            vim.fn.system({ "tmux", "rename-window", name })
        end
    })
    vim.api.nvim_create_autocmd({ "VimLeave" }, {
        pattern = "*",
        callback = function()
            vim.fn.system({ "tmux", "rename-window", "zsh" })
        end
    })
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = event.buf, desc = desc })
        end
        map('gd', vim.lsp.buf.definition, "Go to definition")
        map('K', vim.lsp.buf.hover, "Hover")
        map('gi', vim.lsp.buf.implementation, "Go to implementation")
        map('gr', vim.lsp.buf.references, "References")
        map('<F2>', vim.lsp.buf.rename, "Rename")
        map('<F4>', vim.lsp.buf.code_action, "Code action")
        map('gl', vim.diagnostic.open_float, "Line diagnostics")

        -- `gq` goes through vim.lsp.formatexpr(), which gives up silently after 500ms.
        -- clang-format lexes the whole file even for a range, so huge files need longer.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/rangeFormatting')
            and vim.bo[event.buf].formatexpr == 'v:lua.vim.lsp.formatexpr()' then
            vim.bo[event.buf].formatexpr = 'v:lua.vim.lsp.formatexpr(#{timeout_ms:5000})'
        end
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
local format_group = vim.api.nvim_create_augroup('roginski_format_on_save', {})
vim.api.nvim_create_autocmd('LspAttach', {
    group = format_group,
    callback = function(event)
        local buf = event.buf  -- capture it here
        -- LspAttach fires once per client, but each save should only format once.
        vim.api.nvim_clear_autocmds({ group = format_group, event = 'BufWritePre', buffer = buf })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = format_group,
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
