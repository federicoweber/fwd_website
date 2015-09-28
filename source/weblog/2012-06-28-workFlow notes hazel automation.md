---
title: My mobile notes taking workflow
date: 2012-06-28 19:33:02 +0100
---

When I stumbled upon [Drafts], by Agile Tortoise, I dediced to use it as my mobile note taking app. My choise was dictated by three main reasons:

- it's among the fastest writing app on iOS, ready to write as soon as you start it
- it support textExpander
- it can save the entries to dropbox

## Integrate it in the overall workflow
The only problem was to integrate it within my workflow.
On the mac I am an [nvAlt] user and I'm also using a strict naming convention for my files.
More or less all my notes files names look like this **20120628-193211-NT-0-tag**, where the third element *NT* is the type of the file, in this case a *note*. Unfortunately drafts did not allow me to specify the file name and it can only save the file on the sandboxed */Apps/Drafts* folder inside dropbox.

## Hazel comes to rescue
I did fixed that with the help of [TextExpander], [Hazel] and a little bit of appleScript.

The file name problem is solved using the first paragraph of the note to write it down, the date is included thanks to TextExpander.

Then on the mac i do have an hazel rule that watch the file content for the notes related tokens, run an appleScipt on it and finally move the files to my main notes folder.
![](https://dl.dropbox.com/u/116832/federicoweber.com/20120628-195122-SP-1-workflow%20hazel.jpg)

Here is the script. I think it can be done better, but I've just started learning appleScript.


	-- This script is meant to be executed from Hazel
	-- it will change the file name to the first paragraph 
	-- set the extension to .md
	-- and delete the filename from the file content
	-- by Federico Weber | http://federicoweber.com

	on hazelProcessFile(theFile)
		-- get the file name
		set content to read theFile
		set newFileName to first paragraph of content
		
		-- rename the file
		tell application "Finder"
			set name of theFile to newFileName & ".md"
		end tell
		
		-- delete the name of the file from the content 
		set newContent to get replaceText(newFileName, "", content)
		set openFile to open for access theFile with write permission
		set eof of openFile to 0
		write newContent to openFile starting at eof as text
		close access openFile
		return true
	end hazelProcessFile

	-- replaceText method by Buce Phillis 
	-- http://foolsworkshop.com/applescript/2008/05/an-applescript-replace-text-method/
	on replaceText(find, replace, subject)
		set prevTIDs to text item delimiters of AppleScript
		set text item delimiters of AppleScript to find
		set subject to text items of subject
		
		set text item delimiters of AppleScript to replace
		set subject to "" & subject
		set text item delimiters of AppleScript to prevTIDs
		
		return subject
	end replaceText

[nvAlt]:http://brettterpstra.com/project/nvalt/
[Drafts]:http://agiletortoise.com/drafts
[Hazel]:http://www.noodlesoft.com/hazel.php
[TextExpander]:http://smilesoftware.com/TextExpander/