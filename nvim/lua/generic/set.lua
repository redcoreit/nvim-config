vim.g.mapleader = " "
vim.opt.shadafile = "NONE"
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.opt.relativenumber = true
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 30
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.encoding = "UTF-8"
vim.opt.shortmess:append("c")
vim.opt.cursorline = true
vim.opt.nu = true
vim.api.nvim_set_option("clipboard","unnamedplus")

-- os specific
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.cmd [[
    set nofoldenable

    set ff=dos
    set ffs=dos

    set encoding=utf-8  " The encoding displayed.
    set fileencoding=utf-8  " The encoding written to file.

    " stop add comment on newline
    au FileType * set fo-=c fo-=r fo-=o

    " git diff file format
    au VimLeave * set guicursor=a:hor10-blinkon1
    au BufRead,BufNewFile *.diff set ff=unix 
]]
