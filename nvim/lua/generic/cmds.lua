vim.api.nvim_create_user_command('H', function(opts)
  vim.cmd('h ' .. opts.args)
  vim.cmd('only')
end, {
  nargs = 1,
  complete = 'help'
})
