local cfg = function()
    local opts = {
        notification = {
            window = {
                winblend = 0
            },
            override_vim_notify = true, 
        },

    }

    require("fidget").setup(opts)
end

return {
    {
        "j-hui/fidget.nvim",
        config = cfg
    }
}
