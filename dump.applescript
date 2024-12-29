#!/usr/bin/env osascript

use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

-- set notePath to (path to the documents folder) as string

tell application "Notes"
	activate
	set theNote to note "Doctor"
	show theNote
	set noteTitle to name of theNote
	--set saveAs to notePath & noteTitle
	--	display dialog saveAs
	
	tell application "System Events" to tell process "Notes"
		tell text area 1 of scroll area 2 of splitter group 1 of window "Notes"
			set focused to true
		end tell
		tell menu bar item "Edit" of menu bar 1
			click
			click menu item "Select All" of menu 1
			delay 0.5
		end tell
		tell menu bar item "Edit" of menu bar 1
			click
			click menu item "Copy" of menu 1
		end tell
	end tell
end tell

delay 0.5

tell application "Pages"
	activate
	set thisDoc to make new document
	tell application "System Events" to tell process "Pages"
		tell menu bar item "Edit" of menu bar 1
			click
			click menu item "Paste" of menu 1
		end tell
		click menu item "Word…" of menu 1 of menu item "Export To" of menu 1 of menu bar item "File" of menu bar 1
		tell front window
			repeat until exists sheet 1
				delay 0.02
			end repeat
			tell sheet 1
				click button "Save…"
			end tell
			delay 0.5
			repeat until exists sheet 1
				delay 0.02
			end repeat
			tell sheet 1
				set value of text field "Save As:" to noteTitle
				keystroke return
			end tell
		end tell
	end tell
end tell
