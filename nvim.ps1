[CmdletBinding()]
Param(
    [Parameter(Mandatory = $false)] 
    [string]
    $Profile = "defalut"
)

$Cwd = "$PWD" #.Replace('\','\\') 
$CfgDir = "$PSScriptRoot" #.Replace('\','\\')  

# $Cmd = "`$Env:SANDBOX_NVIM_PWD='$CWD'; cd '$Path'; `$ENV:NVIM_PROFILE='sandbox'; nvim -i NONE -u '$Path\nvim\init.lua' --cmd 'set rtp+=$Path/nvim'"
# $Cmd = "cd '$CWD';`$Env:NVIM_CONFIG='$Path/nvim'; `$Env:NVIM_PROFILE='sandbox'; nvim -i NONE --cmd 'lua vim.env.XDG_CONFIG_HOME=`'$Path`''"



# $Cmd = "& {
#     `$Exec = {
#         `$Profile = `$args[0]
#         `$Cwd = `$args[1]
#         `$CfgDir = `$args[2]
#         # `$Cmd = 'let `$XDG_CONFIG_HOME=`$CfgDir/nvim'
#         `$Cmd = 'lua vim.env.XDG_CONFIG_HOME=`$CfgDir/nvim'
# 
# 
#         Write-Host `$Profile
#         Write-Host `$Cwd
#         Write-Host `$CfgDir
#         Write-Host `$Cmd
# 
#         cd `$Cwd; 
#         `$ENV:NVIM_PROFILE=`$Profile; 
#         nvim -i NONE --cmd `$Cmd;
#     }
#     & `$Exec '$Profile' '$Cwd' '$CfgDir'
# }"
# 
# pwsh -NoProfile -Command $Cmd



$Cmd = "& {
        cd '$Cwd'
        `$Env:NVIM_PROFILE='$Profile'
        `$Env:XDG_CONFIG_HOME=`"$CfgDir\nvim`"
        nvim -i NONE -u '$CfgDir\nvim\init.lua'
}"

Write-Host $Profile
Write-Host $Cwd
Write-Host $CfgDir
Write-Host $Cmd

pwsh -NoProfile -Command $Cmd










#pwsh -NoProfile -Command "& { & $Exec }" "$Profile" "$Cwd" "$CfgDir"

#pwsh -NoProfile -Command "& { $Exec }" "$Profile" "$Cwd" "$CfgDir"

return 

# $Cmd = "`$Env:SANDBOX_NVIM_PWD='$CWD'; cd '$CfgDir'; `$ENV:NVIM_PROFILE='sandbox'; nvim -i NONE -u '$CfgDir\nvim\init.lua' --cmd 'set rtp+=$CfgDir/nvim'"

Write-Verbose $Profile
Write-Verbose $Cwd
Write-Verbose $CfgDir

$Cmd = "`$Env:NVIM_CONFIG='$CfgDir/nvim'; `$Env:NVIM_PROFILE='$Profile'; nvim --cmd 'lua vim.env.XDG_CONFIG_HOME=`'$CfgDir`'' --cmd 'cd `'$CWD`'"

Write-Verbose $Cmd
pwsh -NoProfile -Cmd $Cmd
