---
title: bootstrapping projects
date: 2012-07-17 15:03:46 +0100
---

## Automate project creation
Lately I'm doing a lot of small web projects that, more ore less, have the same folder structure, are based on the same framework, and leverage the same version control system, clearly **Git**.
Therefore I've decided to spend some time to automate the project setup process.

## Meet projectBootstrap
The result of my tinkering is [projectBootstrap](https://github.com/federicoweber/projectBootstrap), a small script in **node.js**, that given a target folder and a configuration file. Take care of populating it, downloading the dependencies, init the Git repo and crete a .taskpaper file to hold the project todo list.

When the script is executed it will look for an **init.json** file inside the target folder. If this is not provided the script will use the default one, that do exist in the script root folder.

### init.json
The init.json is the configuration file used to bootstrap the project, and it's where  the components for the projects are specified. 
It is possible to request the following elements:

- a **boilerplate**, used to setup the initial folder and files structure
- one ore more **Git submodules**
- a series of **libraries**
- a **folder name** to organize the libraries in
- the initial **commit message**
- and the name of the **todo list file**

This is the default init.json you can find on  the github project:

	{
			"boilerplate": "https://github.com/federicoweber/vgHear/raw/master/boilerplate.zip"
		,	"subModules": [
				"https://github.com/federicoweber/vgHear.git"
			]
		, 	"libs": [

			]
		,	"commit": "init Repo"
		,	"libsPath": "app/js/libs"
		,	"todoName": "todo.taskpaper"

	}

## Running the script
The target folder is passed with a **target** environment variable when the script is executed.

Ex.

	$ target=PROJECT_FOLDER node projectBootstrapp.js

To make the process faster I'm also leverging a [keyboard maestro](http://www.keyboardmaestro.com/main/) macro to run the script on the current selected folder in *finder*.

![here is the macro](https://dl.dropbox.com/u/116832/federicoweber.com/20120717-185936-RC-1-automation%20keyboardMaestro.png)

You can find the script on [Github](https://github.com/federicoweber/projectBootstrap).