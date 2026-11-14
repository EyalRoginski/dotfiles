local wk = require('which-key')
wk.setup({})

-- Labels for mappings that are defined without a description
wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>ff", desc = "Files" },
    { "<leader>fa", desc = "All files, including hidden and ignored" },
    { "<leader>fp", desc = "Git files" },
    { "<leader>fg", desc = "Live grep" },
    { "<leader>fm", desc = "Buffers" },
    { "<leader>h", group = "Git hunks" },
    { "<leader>l", group = "LSP symbols" },
    { "<leader>ls", desc = "Document symbols" },
    { "<leader>la", desc = "Workspace symbols" },
    { "<leader>q", group = "Ducks" },
    { "<leader>u", group = "Toggles" },
    { "<leader>pv", desc = "File explorer" },
    { "<leader>w", desc = "Save" },
    { "<leader>W", desc = "Save without autocmds" },
    { "<leader>y", desc = "Yank to clipboard", mode = { "n", "v" } },
    { "<leader>d", desc = "Delete without yanking", mode = { "n", "v" } },
    { "<leader>p", desc = "Paste without yanking", mode = "x" },
    { "<leader>j", desc = "Previous location" },
    { "<leader>k", desc = "Next location" },
    { "<leader>n", desc = "Next buffer" },
    { "<leader>P", desc = "Previous buffer" },
    { "<leader>Y", desc = "Use project venv for Pyright" },
    { "<leader>s", desc = "Replace word under cursor" },
})

-- which-key has no off switch, so remove its triggers from every buffer. This uses its
-- internals, because lowering the popup's visibility would leave it intercepting keys.
local config = require('which-key.config')
local saved_triggers = nil

vim.keymap.set('n', '<leader>uw', function()
    if saved_triggers then
        config.triggers = saved_triggers
        saved_triggers = nil
    else
        saved_triggers = config.triggers
        config.triggers = { mappings = {}, modes = {} }
    end
    require('which-key.buf').clear()
    vim.notify("which-key " .. (saved_triggers and "off" or "on"))
end, { desc = "Toggle which-key" })
