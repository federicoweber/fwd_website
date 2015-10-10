---
title: Street Fighter, combos like, keyboard shortcuts in javascript
date: 2012-07-06 15:48:58 +0100
---

[MouseTrap] is a lightweight, 1.4kb *minified* and *gzipped*, javascript library. Developed by [Creaig Campbell](http://craig.is/). That allow you to, easily create, and listen to keyboard shortcuts.

The sintax for the implementation is as simple as:

	Mousetrap.bind(['command+s', 'ctrl+s'],function(){
		//callback goes here
	});

And it also allow you to declare sequences of keys like this:

	Mousetrap.bind('up up down down left right left right b a enter', function() {
		//callback goes here
	});

You can find it on [github](https://github.com/ccampbell/mousetrap), or test it's awesomeness firing an **Hadoken** *(down down right right a)*

<div id="hadokenHolder"></div>
<script src="https://raw.github.com/ccampbell/mousetrap/master/mousetrap.min.js"></script>
<script>
var init = function(){
	if(typeof $ != 'undefined'){
		loadPlayer();
	} else {
		setTimeout(init,2000)
	}
};

var loadPlayer = function(){
	//Load player api asynchronously.
	var tag = document.createElement('script');
	tag.src = "http://www.youtube.com/player_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	var done = false;
	var player;
	onYouTubePlayerAPIReady = function onYouTubePlayerAPIReady() {
		player = new YT.Player('hadokenHolder', {
			height: '0',
			width: '640',
			videoId: 'pHJKS3r_YUg'
		});
		
		//Listen to combo press
		Mousetrap.bind('down down right right a',function(){
			console.log("now playing")
			$('#hadokenHolder').addClass('play').css({'height': '390px'})
			player.stopVideo()
			player.seekTo(9, false)
			player.playVideo()
			setTimeout(function(){closeHadoken(player)},3000);
		});
		}	
}

var closeHadoken = function(player){
	var currentTime = player.getCurrentTime();
	
	if(currentTime >= 12){
		$('#hadokenHolder').removeClass('play').css({'height': '0'})
		player.stopVideo()
	} else {
		var timeDif = (12 - currentTime )*1000
		setTimeout(function(){closeHadoken(player)},timeDif);
	}
};

init();
</script>
<STYLE type="text/css">
	#hadokenHolder{
		opacity: 0;
		width: 100%;
		overflow: hidden;
		-webkit-transition: all 400ms cubic-bezier(0.190, 1.000, 0.220, 1.000); 
		-moz-transition: all 400ms cubic-bezier(0.190, 1.000, 0.220, 1.000); 
		-o-transition: all 400ms cubic-bezier(0.190, 1.000, 0.220, 1.000); 
		transition: all 400ms cubic-bezier(0.190, 1.000, 0.220, 1.000); /* easeOutExpo */
	}
	
	#hadokenHolder.play{
		opacity: 1;
	}
</STYLE>

[MouseTrap]:http://craig.is/killing/mice  