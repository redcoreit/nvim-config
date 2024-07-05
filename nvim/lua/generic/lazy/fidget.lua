local cfg = function()
    local opts = {
        notification = {
            window = {
                winblend = 0
            },
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
