<#
.Synopsis
    Get Kanbanflow Board
.DESCRIPTION
    Gets all information for a kanbanflow board
    
.EXAMPLE
    Example how to use this cmdlet
.EXAMPLE
    Another example
#>
function Get-Board {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )
    
    begin {
    }
    
    process {
        Invoke-RestMethod -Uri https://kanbanflow.com/api/v1/board?apiToken=$ApiToken
    }
    
    end {
    }
}

<#
.Synopsis
    Get all Tasks from a kanban board
.DESCRIPTION
    Gets all tasks for a kanbanflow board
    
.EXAMPLE
    Example how to use this cmdlet
.EXAMPLE
    Another example
#>
function Get-Tasks {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken
    )
    
    begin {
    }
    
    process {
        Invoke-RestMethod -Uri https://kanbanflow.com/api/v1/tasks?apiToken=$ApiToken
    }
    
    end {
    }
}

<#
.Synopsis
    Get all Tasks from a kanban board - but not nested within 
    columns
.DESCRIPTION
    Gets all tasks for a kanbanflow board
    
.EXAMPLE
    Example how to use this cmdlet
.EXAMPLE
    Another example
#>
function Get-TasksFlat {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string[]]$Columns
    )

    $result = @()
    $tasks = Get-Tasks $ApiToken
    $tasks | 
        Where-Object columnName -in $Columns | 
        Select-Object tasks | % {
            if ($_.tasks -ne $null) {
                $_.tasks | ForEach-Object {
                    $result += ,$_
                }
            } 
        }
    
    return @( $result )
}

<#
.Synopsis
    Get all Tasks from a kanban board - but not nested within 
    columns
.DESCRIPTION
    Gets all tasks for a kanbanflow board
    
.EXAMPLE
    Example how to use this cmdlet
.EXAMPLE
    Another example
#>
function Update-TaskName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$ApiToken,
        [Parameter(Mandatory=$true)]
        [string]$TaskId,
        [Parameter(Mandatory=$true)]
        [string]$NewTaskName
    )

    $credentials = "apiToken:" + $ApiToken
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($credentials))

    Invoke-RestMethod -Headers @{Authorization=("Basic " + $base64AuthInfo)} -Method Post -Uri https://kanbanflow.com/api/v1/tasks/$TaskId -ContentType "application/json" -Body "{ `"name`":`"$NewTaskName`"}"
}

# Exports for the module
Export-ModuleMember -Function Get-Board
Export-ModuleMember -Function Get-Tasks
Export-ModuleMember -Function Get-TasksFlat
Export-ModuleMember -Function Update-TaskName
