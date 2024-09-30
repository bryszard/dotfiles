set posixPath to "/Users/pedro/Movies/"
set folderPath to POSIX file posixPath as alias

tell application "Finder"
	if exists folder folderPath then
		open folder folderPath
	else
		display dialog "The folder does not exist." buttons {"OK"} default button 1
	end if
end tell
