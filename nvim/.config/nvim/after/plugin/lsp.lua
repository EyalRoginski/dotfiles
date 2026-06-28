local is_portable = vim.env.NVIM_PORTABLE == "1"

vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")
if not is_portable then
    vim.lsp.enable("omnisharp")
    vim.lsp.enable("bashls")
end
vim.lsp.enable("clangd")
