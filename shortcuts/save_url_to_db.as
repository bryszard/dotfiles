tell application "System Events"
	set frontmostApplication to name of first application process whose frontmost is true
	set browserName to ""

	if frontmostApplication is "Google Chrome" then
		tell application "Google Chrome" to return URL of active tab of window 1
	else if frontmostApplication is "Firefox" then
		tell process "Firefox"
			keystroke "l" using command down -- Focus the address abr
			keystroke "c" using command down -- Copy the URL
			keystroke tab -- Focus on the next element
		end tell
		delay 1 -- Wait for the clipboard operation to complete
		return the clipboard -- Return the contents of the clipboard
	else if frontmostApplication is "Safari" then
		tell application "Safari" to return URL of current tab of window 1
	end if

end tell

Set variable url to result
Copy url to clipboard
Get contents of <pensaccio url with POST message inside>
Stop and output the result
