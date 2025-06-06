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

vim.api.nvim_create_user_command("Term2", function()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'single',
  })

  local cwd = vim.fn.getcwd():gsub('\\', '/')
  local term_cmd = { 'pwsh', '-nologo', '-noprofile', '-NoExit', '-command', 'cd "' .. cwd .. '"' }
  vim.fn.termopen(term_cmd)
  vim.cmd("startinsert")
end, {})

vim.api.nvim_create_user_command("Test", function()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'single',
  })

  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>q!<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'i', '', { noremap = true, callback = function() end }) -- disable insert

  local cwd = vim.fn.getcwd():gsub('\\', '/')
  local term_cmd = { 'pwsh', '-nologo', '-noprofile', '-NoExit', '-command', 'dotnet trx "' .. cwd .. '"' }

  vim.fn.termopen(term_cmd)
  --vim.cmd("startinsert")
end, {})

--vim.api.nvim_create_user_command("Build", function()
--    vim.cmd('compiler dotnet')
--    vim.cmd('silent make')
--
--    vim.api.nvim_exec_autocmds("User", { pattern = "MakeDotnetFinished" })
--
--    vim.schedule(function()
--        vim.notify("Build finished: " ..  #vim.fn.getqflist())
--    end)
--end, {})

vim.api.nvim_create_user_command("Build", function()
    local output = {}

    vim.cmd('compiler dotnet')

    -- Split makeprg string into args
    local makeprg = vim.o.makeprg
    local args = vim.fn.split(makeprg)

    vim.fn.jobstart(args, {
        --stdout_buffered = false,
        stdout_buffered = true,
        stderr_buffered = true,

        on_stdout = function(_, data)
            if data then
                vim.list_extend(output, data)
                --vim.notify(table.concat(data, "\n"))
            end
        end,

        on_stderr = function(_, data)
            if data then
                vim.list_extend(output, data)
            end
        end,

        on_exit = function(_, exit_code)
            -- Remove empty lines
            local lines = vim.tbl_filter(function(line)
                return line ~= ''
            end, output)

            -- Use Neovim's built-in errorformat to parse into the quickfix list
            vim.fn.setqflist({}, ' ', {
                title = 'make (async)',
                efm = vim.o.errorformat,
                lines = lines,
            })

            if exit_code ~= 0 then
                if #vim.fn.getqflist() > 0 then
                    vim.notify("Build finished: " ..  #vim.fn.getqflist(), vim.log.levels.ERROR)
                else
                    vim.notify("Build not started, no .csproj or .sln found. ", vim.log.levels.WARN)
                end
            else
                vim.notify('Build finished successfully.')
            end

            vim.api.nvim_exec_autocmds("User", { pattern = "MakeDotnetFinished" })
        end,
    })
end, {})
