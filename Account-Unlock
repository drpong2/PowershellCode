<#
.SYNOPSIS
Checks, unlocks, and changes AD user account passwords.

.CONTRIBUTOR
OneHatTwoHatRedHatBlueHat of https://github.com/BeehiveSystems
#>


# Check if a user account is locked
function Is-Locked {
    Try{
        $User = Read-Host -Prompt 'Enter user account to check'
        Get-ADUser -identity $User -Properties * | Select-Object samaccountname, LockedOut | Out-Host
    } Catch {
        'Unable to query successfully'
    }   
}

# Unlock a user account
function Unlock-Account {
    Try{
        $User = Read-Host -Prompt 'Enter user account to unlock'
        Unlock-ADAccount -Identity $User
        Write-Host 'Account has been unlocked'
    } Catch {
        'Unable to query successfully'
    }   
}

# Change a user account password
function Change-Password {
    Try{
        $User = Read-Host -Prompt 'Enter user account to change password'
        $NewPassword = Read-Host -Prompt 'Provide new password' -AsSecureString
        Set-ADAccountPassword -Identity $User -NewPassword $NewPassword -Reset
        Write-Host 'Password has been changed'
    } Catch {
        'Unable to query successfully'
    }   
}

# Display menu options
function Menu {
    Clear-Host
    Write-Host '========== Menu =========='
    Write-Host 'Press "1" to check if an account is locked'
    Write-Host 'Press "2" to unlock a user account'
    Write-Host 'Press "3" to change a user password'
    Write-Host 'Press "q" to quit'
}

# Go to function from menu options
do
{
    Menu
    $input = Read-Host -Prompt 'Make a selection'
    switch ($input)
    {   
        '1'{
            Clear-Host
            Is-Locked
            }
        '2'{
            Clear-Host
            Unlock-Account
            }
        '3'{
            Clear-Host
            Change-Password
            }
        'q'{
            Clear-Host
            return
            }
    }   
    pause
}
