-- shell
vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag = '-nologo -noprofile -command'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

vim.api.nvim_create_user_command("Term", function()
  local cwd = vim.fn.getcwd():gsub('\\', '/')
  local cmd = 'terminal pwsh -nologo -noprofile -command "cd \""' .. cwd .. '\""'

  vim.cmd(cmd)
end, {})

vim.api.nvim_create_user_command("Build", function()
    vim.cmd('compiler dotnet')
    vim.cmd('silent make')

    vim.api.nvim_exec_autocmds("User", { pattern = "MakeDotnetFinished" })

    vim.schedule(function()
        vim.notify("Build finished: " ..  #vim.fn.getqflist())
    end)
end, {})
