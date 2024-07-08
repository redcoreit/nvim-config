local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- builtin
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "Y", "y$", opts)
map("n", "gp", "`[v`]", opts)
map("n", "<C-j>", "<cmd>cnext<CR>zz", opts)
map("n", "<C-k>", "<cmd>cprev<CR>zz", opts)
map("n", "_", ":e %:p:h<CR>", opts)
map("n", "<leader>yp", ":lua vim.fn.setreg(\"+\", vim.fn.expand(\"%:p\"))<CR>", opts)
map("n", "<leader>q", "<cmd>cclose<CR>", opts)
map("v", "p", "P", opts)
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("v", "<leader>q", "<cmd>cclose<CR>", opts)
map("t", "<ESC>", "<C-\\><C-n>", opts)

-- harpoon
map("n", "<leader>hh", function() 
    local harpoon = require("harpoon")
    harpoon:list():add()
end, opts)
map("n", "<leader>hw", function() 
    local harpoon = require("harpoon")
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, opts)
map("n", "<C-a>", function() 
    local harpoon = require("harpoon")
    harpoon:list():select(1)
end, opts)
map("n", "<C-s>", function()
    local harpoon = require("harpoon")
    harpoon:list():select(2)
end, opts)
map("n", "<C-f>", function() 
    local harpoon = require("harpoon")
    harpoon:list():select(3)
end, opts)
map("n", "<C-g>", function() 
    local harpoon = require("harpoon")
    harpoon:list():select(4)
end, opts)

-- telescope
map("n", "gr", ":Telescope lsp_references<CR>", opts)
map("n", "<leader>tt", ":Telescope<CR>", opts)
map("n", "<leader>th", ":Telescope help_tags<CR>", opts)
map("n", "<Leader>\\", ":lua require('telescope').extensions.recent_files.pick({only_cwd=true})<CR>", opts)
map("n", "<leader>|", ":Telescope git_files<CR>", opts)
map("n", "<leader>'", ":Telescope live_grep<CR>", opts)
map("n", "<leader>;", ":Telescope find_files<CR>", opts)
map("n", "<leader>:",  function() 
    require('telescope.builtin').find_files { 
        search_file = vim.fn.expand("<cword>") 
    }
end, opts)
map("n", "<leader>/",  function() 
    require('telescope.builtin').grep_string { 
        search = vim.fn.expand("<cword>") 
    }
end, opts)
map("n", "<leader>?",  function() 
    require('telescope.builtin').grep_string { 
        search = vim.fn.expand("<cWORD>") 
    }
end, opts)
map("n", "<leader>td", function() 
    require('telescope.builtin').diagnostics {
        severity = vim.diagnostic.severity.ERROR
    }
end, opts)

-- copilot
map('i', '<C-o>', '<Plug>(copilot-accept-word)')
vim.cmd [[
    imap <silent><script><expr> <C-p> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:false
]]

-- shortcuts
map("v", "<leader>s", function() 
    local keys = vim.api.nvim_replace_termcodes(':s#\\v#g<Left><Left>', true, true, true)
    vim.api.nvim_feedkeys(keys, 'v', true)
end, opts)

map("v", "<leader>n", function() 
    local keys = vim.api.nvim_replace_termcodes(':norm!', true, true, true)
    vim.api.nvim_feedkeys(keys, 'v', true)
end, opts)

-- lsp
local lsp_map = function(map, opts)
    --map('n', 'gr', vim.lsp.buf.references, opts)
    map("i", "<C-h>", vim.lsp.buf.signature_help, opts) 
    map("n", "<C-h>", vim.lsp.buf.signature_help, opts) 
    map('n', '<leader>i', vim.diagnostic.open_float, opts)
    map('n', '<leader>k', vim.lsp.buf.hover, opts)
    map('n', '<leader>cn', vim.lsp.buf.rename, opts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    map('n', '<leader>f', vim.lsp.buf.format, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gt', vim.lsp.buf.type_definition, opts)
    map('n', '[d', vim.diagnostic.goto_prev, opts)
    map('n', ']d', vim.diagnostic.goto_next, opts)
    map('n', '<leader>i', vim.diagnostic.open_float, opts)
    map('n', '<leader>q', vim.diagnostic.setqflist, opts)

    -- cmp
    --map('i', '<Enter>', "<cmd>lua require('cmp').confirm({ select = true })<CR>", opts)
    --map('i', '<C-Space>', "<cmd>lua require('cmp').complete()<CR>", opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(e)
        local map = vim.keymap.set
        local opts = { buffer = e.buf }
        lsp_map(map, opts)

        print("LspAttach")
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable()
        end
    end
})
