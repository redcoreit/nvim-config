local cfg = function()
    require('csvview').setup({
        view = {
            display_mode = "border"
        }
    })
end

return {
    {
        'hat0uma/csvview.nvim',
        config = cfg
    }
}
