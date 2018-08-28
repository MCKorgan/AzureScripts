param(
    [string] $userName,
    [secureString] $password,
    [string] $fullName,
    [string] $description,
    [string] $groupName
)

New-LocalUser $userName -Password $password -FullName $fullName -Description $description
Add-LocalGroupMember -Group $groupName -Member $userName