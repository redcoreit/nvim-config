local cfg = function()
    vim.cmd [[
        let g:copilot_filetypes = {
            \ '*': v:true,
            \ 'python': v:true,
            \ }
    ]]
end

return {
    {
        "github/copilot.vim",
        config = cfg,
    }
}
