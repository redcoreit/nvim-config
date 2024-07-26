[CmdletBinding()]
Param(
    [Parameter(Mandatory = $false)] 
    [string]
    $Profile = "defalut"
)

$Cwd = "$PWD" #.Replace('\','\\') 
$CfgDir = "$PSScriptRoot" #.Replace('\','\\')  

$Cmd = "& {
        cd '$Cwd'
        `$Env:NVIM_PROFILE='$Profile'
        `$Env:XDG_CONFIG_HOME=`"$CfgDir`"
        nvim -i NONE -u '$CfgDir\nvim\init.lua'
}"

Write-Verbose $Profile
Write-Verbose $Cwd
Write-Verbose $CfgDir
Write-Verbose $Cmd

pwsh -NoProfile -Command $Cmd
