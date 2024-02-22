local luasnip = require('luasnip')
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
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
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
