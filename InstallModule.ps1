param([string]$Scope = "AllUsers")

$ModuleName   = "InstallModuleFromGitHub"
$AllUsersPath   = "$env:ProgramFiles\WindowsPowerShell\Modules"
$CurrentUserPath = "$env:USERPROFILE\Documents\WindowsPowershell\Modules"
$ScopePaths = @{
    AllUsers = "$AllUsersPath\$ModuleName"
    CurrentUser = "$CurrentUserPath\$ModuleName"
}
$TargetPath = $ScopePaths["$Scope"]

if(!(Test-Path $TargetPath)) {
    md $TargetPath | out-null
}

$targetFiles = echo `
    *.psm1 `
    *.psd1 `
    License.txt `

ls $targetFiles |
    ForEach {
        Copy-Item -Verbose -Path $_.FullName -Destination "$($TargetPath)\$($_.name)"
    }
