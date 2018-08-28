param(
    [string] $userName,
    [string] $password,
    [string] $fullName,
    [string] $description,
    [string] $groupName
)

$secure = ConvertTo-SecureString $password -AsPlainText -Force

New-LocalUser $userName -Password $secure -FullName $fullName -Description $description
Add-LocalGroupMember -Group $groupName -Member $userName