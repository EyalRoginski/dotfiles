local pid = vim.fn.getpid()

return {
    cmd = {
        "omnisharp",
        "--languageserver",
        "--hostPID", tostring(pid),
    },
    filetypes = { "cs" },
    root_markers = { "*.sln", "*.csproj", ".git" },
    settings = {
        omnisharp = {
            enableRoslynAnalyzers = true,
            enableEditorConfigSupport = true,
            sdkPath = vim.fn.trim(vim.fn.system("dirname $(which dotnet)")),
        },
    },
}
