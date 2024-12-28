#!/usr/bin/env osascript

use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

set notePath to (path to the documents folder) as string

tell application "Notes"
	activate
	set theNote to note "Giant Davey"
	show theNote
	set noteTitle to name of theNote
	set saveAs to notePath & noteTitle
	display dialog saveAs

	tell application "System Events" to tell process "Notes"
		tell text area 1 of scroll area 2 of splitter group 1 of window "Notes"
			set focused to true
		end tell
		tell menu bar item "Edit" of menu bar 1
			click
			click menu item "Select All" of menu 1
			delay 1
		end tell
		tell menu bar item "Edit" of menu bar 1
			click
			click menu item "Copy" of menu 1
		end tell
	end tell
end tell
delay 1
tell application "TextEdit"
	activate
	set thisDoc to make new document
	tell application "System Events" to tell process "TextEdit"
		tell menu bar item "Edit" of menu bar 1
			click
			click menu item "Paste" of menu 1
		end tell
	end tell
	save thisDoc in file saveAs
end tell
