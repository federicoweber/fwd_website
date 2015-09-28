---
title: From Twitter and RSS to OmniFocus
---

I'm a voracious user of Flipboard, and during my daily reading I often stumble upon news that I wish to do more with: softwares I wish to try, news to writing about, etc.
To accomplish that i was using a series of [IFTTT] rules to send this content to my email; with the result of ending up with a quite polluted email inbox.

Today [Federico Viticci](https://twitter.com/viticci) published it's, IFTTT and [Hazel], [workflow](http://www.macstories.net/tutorials/send-favorite-tweets-to-omnifocus-inbox/) to save starred tweets to OmniFocus, leveraging IFTTT and Hazel.
Inspired by that I've created two IFTTT recipes and two Hazel rules to achieve the same for both twitter and google reader.

The IFTTT recieps are the following:
 
- one for [twitter](https://ifttt.com/recipes/54060) 
- one for [google reader](https://ifttt.com/recipes/54062)

Both are structured to create a text file inside a specified dropbox folder. The output is designed as a multiline text files.
The first first of which is used as the OF entry **title** and the rest of the content is passed in as the **note**.

The first of the Hazel rules is conceived to run an **appleScript** to the content of the file—to encode the text in **UTF-8**, parse it and create the new entry in the OmniFocus **inBox**.—, set the label to green (to know which files have been processed) and confirm the entry via Notification Center (using the automator action provided by [Automated Workflows](http://www.automatedworkflows.com/2012/08/26/display-notification-center-alert-automator-action-1-0-0/)).

![The Hazel rule to watch the files](https://dl.dropbox.com/u/116832/federicoweber.com/20120831-205446-NT-0-hazel.png)

The appleScript to parse the conent:

	-- This script is meant to be executed from Hazel
	-- It is used to create a new task inside omnifocus 
	-- The first paragraph is used for the title, the others are passed in the notes
	-- by Federico Weber | http://federicoweber.com
	
	on hazelProcessFile(theFile)
		-- get the Title of the task
		set content to read theFile as «class utf8»
		set title to first paragraph of content
		
		-- Get the note of the Task
		set noteContent to get replaceText(title, "", content)
		
		tell application "OmniFocus"
			set theDoc to first document
			tell theDoc
				make new inbox task with properties {name:title, note:noteContent}
			end tell
		end tell
		
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


The second rules is used to erase the file after one week if the file have been properly parsed. I could have used just one rule and delete the content after it have been parsed, but I prefer to keep the files longer to fallback if something goes bad.


[IFTTT]:http://ifttt.com
[Hazel]:http://www.noodlesoft.com/hazel.php

If you found this useful please let me know via [twitter](http://twitter.com/FedericoWeber) or [app.net](https://alpha.app.net/federicoweber).