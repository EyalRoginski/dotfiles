require('gitsigns').setup {
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        local function visual_range()
            return { vim.fn.line('.'), vim.fn.line('v') }
        end

        -- Navigation, keeping the built-in ]c and [c in diff mode
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end, "Next hunk")
        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end, "Previous hunk")

        -- Staging a hunk that is already staged unstages it
        map('n', '<leader>hs', gitsigns.stage_hunk, "Stage hunk")
        map('n', '<leader>hr', gitsigns.reset_hunk, "Reset hunk")
        map('v', '<leader>hs', function() gitsigns.stage_hunk(visual_range()) end, "Stage selection")
        map('v', '<leader>hr', function() gitsigns.reset_hunk(visual_range()) end, "Reset selection")
        map('n', '<leader>hS', gitsigns.stage_buffer, "Stage buffer")
        map('n', '<leader>hR', gitsigns.reset_buffer, "Reset buffer")

        -- Inspection
        map('n', '<leader>hp', gitsigns.preview_hunk, "Preview hunk")
        map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, "Blame line")
        map('n', '<leader>hB', gitsigns.blame, "Blame file")
        map('n', '<leader>hd', gitsigns.diffthis, "Diff file")

        -- Hunk text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, "Inner hunk")
    end,
}
