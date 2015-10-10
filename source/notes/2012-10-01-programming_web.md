---
title: Validating your Local Storage Data
published: true
---

Local storage is a powerfull tool to cache data computed by web apps for later reuse or non critical persistency[^1]. For example I do used it on a recent project, to reduce both the data loaded from the server and the computational cost of sorting a huge list of articles by filters.

Cause the local storage will persiste on the browser for a long time to safely use this data we have to be sure that they are reliable and up to date. Usually the data can get useless for two main reasons: they are based on data produce by the server, that has been updated; or they have been stored by a previous version of the web app which data model have long changed.

## Getting the timestamp
To check the data against the server a good option is to have it provide a timestamp[^2] for the latest time the data have been changed. 

If the web page, is rendered by the same server we are getting the data from, we can pass this information around as a **Custom data attributes** in the DOM element that hold the app.

```html
<div id="appHolder" data-timestamp="2012-10-02T20:17:08.780Z"></div>
```

Otherwise, if the data are coming from a different server, we can get the information as a lightweight JSON.

```json
{"updated": "2012-10-02T18:30:30.179Z" }
```

## Versioning your web app
To match the data against an updated version of your app the best option is to have a the version number as constant in your app namespace, and save it with your data on the Local Storage.

```javascript
myApp = {}; myApp.VERSION = "0.0.4";
```

## Wrapping it up 
It's best to run this test as soon as the app is inited, if both of this test succeed you are usually safe to trust the stored data, otherwise it's reccomended to recreate it.


[^1]:With non critical persistency I intend any kind of data that can be reconstructed without causing damages or requiring serius effort from the end user. Like a precompiled set of filters for a search.

[^2]: Although not mandatory I reccomend you to store this data in the ISO format *"2012-10-02T20:17:08.780Z"* to better reuse it in javascript passing it as an argument of a new Date object.
