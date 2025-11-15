--
--  AppDelegate.applescript
--  TuxPaint Stamps Installer
--
--  Copyright (c) 2004-2022
--  Created by Martin Fuhrer on 09/11/04
--  Subsequent contributions by various authors
--  https://www.tuxpaint.org/
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--  (See COPYING.txt)
--

script AppDelegate
    property parent : class "NSObject"
    property theSelectedRadioButtonId : "USER"

    -- IBOutlets
    property theWindow : missing value
    property theUserRadioButton : missing value
    property theSystemRadioButton : missing value
    property theApplicationRadioButton : missing value
    property theInstallButton : missing value
    property theRemoveButton : missing value
    property theQuitButton : missing value

    -- Application startup
    on applicationWillFinishLaunching_(aNotification)
        refresh()
    end applicationWillFinishLaunching_

    -- Application cleanup
    on applicationShouldTerminate_(sender)
        return current application's NSTerminateNow
    end applicationShouldTerminate_

    on applicationShouldTerminateAfterLastWindowClosed_(sender)
        return true
    end applicationShouldTerminateAfterLastWindowClosed_

    -- Refresh the dialog box
    on refresh()
        set myVersion to installerVersion()
        set userInstalledVersion to stampsVersionAt(stampsPathOf("USER"))
        set systemInstalledVersion to stampsVersionAt(stampsPathOf("SYSTEM"))

        -- Display the user installed versions
        if userInstalledVersion is missing value then
            set title of theUserRadioButton to "Current User"
        else if userInstalledVersion is myVersion then
            set title of theUserRadioButton to "Current User (Current version installed)"
        else
            set title of theUserRadioButton to "Current User (ver. " & userInstalledVersion & " installed)"
        end if

        -- Display the system installed versions
        if systemInstalledVersion is missing value then
            set title of theSystemRadioButton to "All Users"
        else if systemInstalledVersion is myVersion then
            set title of theSystemRadioButton to "All Users (Current version installed)"
        else
            set title of theSystemRadioButton to "All Users (ver. " & systemInstalledVersion & " installed)"
        end if

        -- Refresh the buttons
        refreshButtons()
    end refresh

    -- Enable and disable appropriate buttons
    on refreshButtons()
        -- Enable both buttons by default
        set enabled of theInstallButton to true
        set enabled of theRemoveButton to true

        -- We're done if the application is selected
        if theSelectedRadioButtonId is "APPLICATION" then
            return
        end if

        -- Get the installer version and the installed stamps version
        set myVersion to installerVersion()
        set installedVersion to stampsVersionAt(stampsPathOf(theSelectedRadioButtonId))

        # -- Disable the install button if the current version is already installed
        # if myVersion is installedVersion then
        #     set enabled of theInstallButton to false
        # end if

        -- Disable the remove button if the selected target has no package to remove
        if installedVersion is missing value then
            set enabled of theRemoveButton to false
        end if
    end refreshButtons

    -- Disable all buttons
    on disableButtons()
        set enabled of theInstallButton to false
        set enabled of theRemoveButton to false
    end disableButtons

    -- Return the version of the installer
    on installerVersion()
        set appBundle to current application's NSBundle's mainBundle()
        set appVersion to appBundle's objectForInfoDictionaryKey:("CFBundleShortVersionString")

        return appVersion as text
    end installerVersion

    -- Return the installed stamps version, if any
    on stampsVersionAt(thePath)
        set versionString to missing value

        # Get the first line from the version file, if it exists
        try
            set versionFile to paragraphs of (read thePath & "/stamps/version")

            repeat with l in versionFile
                set versionString to l as text
                exit repeat
            end repeat
        end try

        return versionString
    end stampsVersionAt

    -- Handle radio button selection event
    on selected_(theRadioButton)
        set theSelectedRadioButtonId to theRadioButton's identifier() as text

        refreshButtons()
    end selected_

    -- Handle button click event
    on clicked_(theButton)
        set theButtonId to theButton's identifier() as text

        if theButtonId is "INSTALL" then
            install(stampsPathOf(theSelectedRadioButtonId))
        else if theButtonId is "REMOVE" then
            uninstall(stampsPathOf(theSelectedRadioButtonId))
        else if theButtonId is "QUIT" then
            quit
        else
            ackDialog("We shouldn't get here: theButtonId=" & theButtonId)
        end if
    end clicked_

    -- Given an abstract target name, return the path to its resources folder
    on stampsPathOf(theTargetId)
        set thePath to missing value

        if theTargetId is "SYSTEM" then
            set thePath to "/Library/Application Support/TuxPaint"
        else if theTargetId is "USER" then
            set HOME to system attribute "HOME"
            set thePath to HOME & "/Library/Application Support/TuxPaint"
        else if theTargetId is "APPLICATION" then
            repeat while true
                -- Bring up the file chooser
                set thePath to choose file with prompt "Please select the Tux Paint application:" of type "app"
                set thePath to POSIX path of thePath
                
                -- Break if Tux Paint is chosen
                tell application "System Events"
                    if exists file (thePath & "/Contents/MacOS/Tux Paint") then      -- Old macOS
                        set thePath to thePath & "/Contents/Resources"
                        exit repeat
                    else if exists file (thePath & "/Contents/MacOS/TuxPaint") then  -- New macOS
                        set thePath to thePath & "/Contents/Resources"
                        exit repeat
                    else if exists file (thePath & "/tuxpaint") then                 -- iOS
                        exit repeat
                    end if
                end tell

                -- Otherwise raise an error message then bring up the file chooser again
                ackDialog("Sorry, the selected application does not appear to be Tux Paint!")
            end repeat
        else
            ackDialog("We shouldn't get here: theTargetId=" & theTargetId)
        end if
        
        return thePath
    end stampsPathOf

    on install(thePath)
        set myVersion to installerVersion()
        set versionPath to thePath & "/stamps/version"
        set archivePath to POSIX path of (path to resource "tuxpaint-stamps.tar.gz")
        set quotedPath to quoted form of thePath
        set quotedVersion to quoted form of myVersion
        set quotedVersionPath to quoted form of versionPath
        set quotedArchivePath to quoted form of archivePath
        set stampSetsToInstall to stampsSetChooser()
        set isInstalled to false

        # -- Disable the buttons
        # disableButtons()

        -- Build the shell command to install the stamp set(s)
        set command to "mkdir -p " & quotedPath & " && tar xzvf " & quotedArchivePath & " -C " & quotedPath
        repeat with stampSet in stampSetsToInstall
            set command to command & " " & quoted form of ("stamps/" & stampSet)
        end repeat
        set command to command & " && printf '%s\n' " & quotedVersion & " > " & quotedVersionPath

        -- Try to install as user
        try
            do shell script command
            set isInstalled to true
        end try

        -- Otherwise try to install as admin
        if not isInstalled then
            do shell script command with administrator privileges
            set isInstalled to true
        end if

        -- Report status
        if isInstalled then
            ackDialog("Tux Paint stamps have been successfully installed!")
        else
            ackDialog("Sorry, Tux Paint stamps could not be installed.")
        end if

        -- Refresh the dialog box and the buttons
        refresh()
    end install

    on uninstall(thePath)
        set quotedPath to quoted form of (thePath & "/stamps")
        set command to "rm -rf " & quotedPath
        set isRemoved to false

        # -- Disable the buttons
        # disableButtons()

        -- Try to remove as user
        try
            do shell script command
            set isRemoved to true
        end try

        -- Otherwise try to remove as admin
        if not isRemoved then
            do shell script command with administrator privileges
            set isRemoved to true
        end if

        -- Report status
        if isRemoved then
            ackDialog("Tux Paint stamps have been successfully removed!")
        else
            ackDialog("Sorry, Tux Paint stamps could not be removed.")
        end if

        -- Refresh the dialog box and the buttons
        refresh()
    end uninstall

    on stampsSetChooser()
        set archiveListPath to POSIX path of (path to resource "tuxpaint-stamps.list")
        set stampsSetList to {}
        set selectedSetList to missing value

        # Get the list of installable stamp sets
        repeat with l in paragraphs of (read archiveListPath)
            if length of l is greater than 0 then
                copy l as text to the end of the stampsSetList
            end if
        end repeat

        # Ask user for the set(s) to install
        set selectedSetList to choose from list stampsSetList             ¬
                with title "Stamp Set Chooser"                            ¬
                with prompt "Please select the stamp set(s) to install:"  ¬
                with multiple selections allowed                          ¬
                default items stampsSetList

        return selectedSetList
    end stampsSetChooser

    on ackDialog(message)
        display dialog message buttons {"OK"} default button 1 with icon 1
    end ackDialog
end script
