local is_portable = vim.env.NVIM_PORTABLE == "1"

vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
if not is_portable then
    vim.lsp.enable("basedpyright")
    vim.lsp.enable("omnisharp")
end
vim.lsp.enable("clangd")
vim.lsp.enable("bashls")
