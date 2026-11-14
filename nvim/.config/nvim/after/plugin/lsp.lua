local is_portable = vim.env.NVIM_PORTABLE == "1"

vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")
if not is_portable then
    vim.lsp.enable("omnisharp")
    vim.lsp.enable("bashls")
end
vim.lsp.enable("clangd")
if vim.fn.executable("nixd") == 1 then
    vim.lsp.enable("nixd")
end
-- Connects to the Godot editor's built-in server (port 6005), so the editor must be running
vim.lsp.enable("gdscript")
if vim.fn.executable("gdshader-lsp") == 1 then
    vim.lsp.enable("gdshader_lsp")
end
