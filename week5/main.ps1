. (Join-Path $PSScriptRoot ./gatherClasses.ps1)

clear
$FullTable = gatherClasses

$FullTable = daysTranslator $FullTable

#Find Furkan
#$FullTable | select "Class Code", Instructor, Location, Days, "Time Start", "Time End" | where {$_."Instructor" -ilike "*Furkan*"}

#JOYC 310
#$FullTable | where-object {($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday")} | sort "Time Start" | select "Time Start", "Time End", "Class Code"


$ITSInstructors = $FullTable | where-object { 
($_."Class Code" -ilike "SYS*") -or `
($_."Class Code" -ilike "NET*") -or `
($_."Class Code" -ilike "SEC*") -or `
($_."Class Code" -ilike "FOR*") -or `
($_."Class Code" -ilike "CSI*") -or `
($_."Class Code" -ilike "DAT*")} | Sort-Object "Instructor" | select "Instructor" -Unique

#$ITSInstructors

$FullTable | where { $_.Instructor -in $ITSInstructors.Instructor } `
| group-object "Instructor" | Select Count,Name | Sort-Object Count -Descending