local pid = vim.fn.getpid()
-- The binary is called OmniSharp when installed through Nix
local cmd = vim.fn.executable("OmniSharp") == 1 and "OmniSharp" or "omnisharp"
local sdk_path = nil
if vim.fn.executable("dotnet") == 1 then
    sdk_path = vim.fn.fnamemodify(vim.fn.exepath("dotnet"), ":h")
end

return {
    cmd = {
        cmd,
        "--languageserver",
        "--hostPID", tostring(pid),
    },
    filetypes = { "cs" },
    root_markers = { "*.sln", "*.csproj", ".git" },
    settings = {
        omnisharp = {
            enableRoslynAnalyzers = true,
            enableEditorConfigSupport = true,
            sdkPath = sdk_path,
        },
    },
}
