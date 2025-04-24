local cfg = function()
    local opts =  { 
        default_register = '"',
        preview = false, 
        content_spec_column = true
    }
    require('neoclip').setup(opts)
end

return {
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = {
            -- {'kkharji/sqlite.lua', module = 'sqlite'},
            {'nvim-telescope/telescope.nvim'},
        },

        config = cfg
    }
}
