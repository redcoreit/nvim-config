[CmdletBinding()]
Param(
    [Parameter(ValueFromRemainingArguments = $true)] 
    $Args
)

$Profile = "default"
if ($Args) {
    $ProfileIndex = [array]::IndexOf($Args, "--Profile")
    if ($ProfileIndex -ge 0 -and $ProfileIndex + 1 -lt $Args.Count) {
        # Extract the profile value
        $Profile = $Args[$ProfileIndex + 1]

        # Convert $Args to a List to allow removing elements
        $ArgsList = [System.Collections.Generic.List[object]]::new()
        $ArgsList.AddRange($Args)

        # Remove --Profile and its associated value
        $ArgsList.RemoveAt($ProfileIndex + 1) # Remove the profile value
        $ArgsList.RemoveAt($ProfileIndex)     # Remove --Profile

        # Convert back to array
        $Args = $ArgsList.ToArray()
    }
}

$Cwd = "$PWD" #.Replace('\','\\') 
$CfgDir = "$PSScriptRoot" #.Replace('\','\\')  

$Cmd = "& {
        cd '$Cwd'
        `$Env:NVIM_PROFILE='$Profile'
        `$Env:XDG_CONFIG_HOME=`"$CfgDir`"
        nvim -i NONE -u '$CfgDir\nvim\init.lua' $Args 
}"

Write-Verbose $Profile
Write-Verbose $Cwd
Write-Verbose $CfgDir
Write-Verbose $Cmd

pwsh -NoProfile -Command $Cmd
