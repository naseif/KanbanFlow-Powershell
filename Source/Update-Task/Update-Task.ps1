<#
.Synopsis
    Update the name of a task

.DESCRIPTION
    Update a task name on a kanban board by taskId
    
.EXAMPLE
    Update-Task -ApiToken "..." -TaskId "..." -NewTaskName "New task name"
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

    $data = New-Object psobject
    $data | Add-Member NoteProperty -Name "name" -Value $NewTaskName

    KanbanflowApi-PostCommand -ApiToken $ApiToken -TaskId $TaskId -data $data
}