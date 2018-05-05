<#

    Execute all unit tests

#>
Import-Module Pester -RequiredVersion 4.3.1
$filesToCover = Get-ChildItem .\Source -File -Recurse -Include *.ps1
Invoke-Pester -Path "./Tests" -CodeCoverage $filesToCover