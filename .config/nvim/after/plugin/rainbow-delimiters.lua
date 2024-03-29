local palette = require('nordic.colors')

-- Confused? I'd rather not change the order and change just the actual colors,
-- so I'm assigning colors from the theme with no regard for the names of the hightlight
-- groups.
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = palette.cyan.base })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = palette.yellow.base })
vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = palette.red.base })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = palette.magenta.dim })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = palette.blue0 })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = palette.orange.base })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = palette.green.dim })

require('rainbow-delimiters.setup').setup {
    highlight = {
        'RainbowDelimiterCyan',
        'RainbowDelimiterYellow',
        'RainbowDelimiterViolet',
        'RainbowDelimiterOrange',
        'RainbowDelimiterBlue',
        'RainbowDelimiterRed',
        'RainbowDelimiterGreen',
    },
}
