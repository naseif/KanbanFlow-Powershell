Import-Module $PSScriptRoot/../../Source/Kanbanflow.psm1
. $PSScriptRoot/../../credentials-for-testing.ps1

Describe 'Get-BoardColumn' {

    It 'grabs information about the column from the testing board by name' {
        $todoColumn = Get-BoardColumn -ApiToken $testBoardApiToken -Label "To-Do"

        $todoColumn | Should -Not -BeNullOrEmpty
        $todoColumn.uniqueId | Should -Be "tgGDUJmo1W72"
        $todoColumn.name | Should -Be "To-do"
    }

    It 'grabs information about the column from the testing board by uniqueId' {
        $todoColumn = Get-BoardColumn -ApiToken $testBoardApiToken -UniqueId "tgGDUJmo1W72"

        $todoColumn | Should -Not -BeNullOrEmpty
        $todoColumn.uniqueId | Should -Be "tgGDUJmo1W72"
        $todoColumn.name | Should -Be "To-do"
    }

    It 'grabs a list of all columns in case there is no filter value present' {
        $todoColumn = Get-BoardColumn -ApiToken $testBoardApiToken

        $todoColumn | Should -Not -BeNullOrEmpty
        $todoColumn.length | Should -Be 4
    }

    It 'will return null if it cannot find a matching column' {
        $todoColumn = Get-BoardColumn -ApiToken $testBoardApiToken -Label "Not Existing"

        $todoColumn | Should -BeNullOrEmpty
    }

}