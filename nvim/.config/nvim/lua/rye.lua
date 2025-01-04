local M = {}

M.get_venv_path = function()
    local handle = io.popen("rye show | rg '(/.*\\.venv)' -o")
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result:gsub("%s+", "") -- remove any trailing whitespace/newlines
    end
    return nil
end

M.set_pyright_interpreter = function()
    local venv_path = M.get_venv_path()
    if venv_path then
        local python_path = venv_path .. "/bin/python"
        vim.lsp.start({
            name = 'pyright',
            cmd = { 'pyright-langserver', '--stdio' },
            root_dir = vim.fn.getcwd(),
            settings = {
                python = {
                    pythonPath = python_path,
                },
            },
        })
    end
end

-- Autocmd to switch Pyright interpreter for Python files
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.py",
    callback = function()
        M.set_pyright_interpreter()
    end,
})

return M

