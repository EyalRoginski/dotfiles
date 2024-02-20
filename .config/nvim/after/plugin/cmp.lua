local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup {
    mapping = {
        ['<Tab>'] = function(fallback)
            -- Select the first one if none is selected.
            if not cmp.get_selected_entry() then
                cmp.select_next_item()
            end
            if cmp.visible() then
                cmp.confirm()
            else
                fallback()
            end
        end,
        ['<CR>'] = function(fallback)
            -- Select the first one if none is selected.
            if not cmp.get_selected_entry() then
                cmp.select_next_item()
            end
            if cmp.visible() then
                cmp.confirm()
                vim.api.nvim_input("<CR>")
            else
                fallback()
            end
        end,
        ['<C-j>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<C-k>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    }
}
