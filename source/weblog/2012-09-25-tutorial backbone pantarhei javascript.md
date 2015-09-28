---
title: Front end middleware with Backbone and PantaRhei
published: true
---

## A middleware primer

The first time I've stumbled upon  the middleware pattern it was in [Express.js], while developing the backend for [Gestalt]. 

The concept of middleware it's quite straight forward, it's nothing more than a function that handle a request. What make it so interesting is the possibility to create a stack of middleware. By doing so each middleware will be able to process the request, and call the next one in the stack.

A typical middleware will look like this:

	var foo = function(req, res, next) {
		// all your logic goes in here
		
		// proceed to the next middleware
		next();
	};
	
If a middleware have to signal an error, it can do so passing it to the first argument of the next().

	var bar = function(req, res, next) {
		// signal an error
		next( "Something went wrong!" );
	};

To append a stack of middleware to a request in [Connect] you have to declare them with the **use** method[^1].
	
	// Example from http://www.senchalabs.org/connect/
	var app = connect()
		.use(connect.logger('dev'))
		.use(connect.static('public'))
		.use(function(req, res){
			res.end('hello world\n');
		})
		.listen(3000);


What I really like about this pattern is that by simply reading the **use** stack you can get a grip on the logics behind the application. Also structuring your application as a cascade of middleware you are encouraged to split it in small,  self contained, modules and avoid nasty callbacks. With the added benefit of a enhancing both the readability maintainability of your code.

## Introducing PantaRhei.js

[PantaRhei.js](http://github.com/federicoweber/PantaRhei) is my front end implementation of the middleware pattern . I structured it as an extension for [Backbone.js] because it is awesome, I'm using it on the wast majority of my projects, and I want to leverage it's **Events** module and the simple inheritance style provided by the **extend()** method. 

PantaRhei is written in CoffeeScript and distributed with the MIT license. You can find the coffeescript sources and the compiled and minified javascript files on [Github](http://github.com/federicoweber/PantaRhei). 

The purpose of PantaRhei is to ease the creation and the execution of queues of tasks, like fetching and manipulating data, managing the transitions between pages and so on.
Right now PantaRhei is composed by two modules: the **Flow**, that is responsible for the execution of the queue and the **Worker**, that describe one of the possible structure of middleware[^2] that the Flow can handle.

### The Worker
The **Worker** module is more a convention than a real module, and it's meant to be extended. 
It describe two methods: the former is the **run** it's invoked by the Flow to execute the worker and accept a **shared** object ( which purpose is to act as a place for workers to share data ) and the **next** callback as arguments; the latter is the **kill**, that is invoked by the Flow when the worker execution is completed to safely remove it.
The worker constructor also accept an option **id** as an argument.

To create a new Worker you need to extend it and implement it's methods:

	var Delay = PantaRhei.Worker.extend({
		constructor: function(duration, id){
			this.duration = duration;
			this.id = id;
		},
		run: function(shared, next) {
			onTimeout = function(){
				next();
			};
			setTimeout(onTimeout, duration);
		},
		kill: function(){
			// all your logics to remove the worker
		}
	});
	
	var shortDelay = new Delay(1000, 'shortDelay');

PantaRhei also include, under the PantaRhei.workers namespace, a series of workers[^3] JsonLoader and LoadAssets.

### The Flow
The **Flow** module is our middleware manager, and handle for you all the logic to create and run the queue.
To create a new flow all you have to do is to call it's constructor and optionally pass two parameters: an **id** and a array containing the list of **workers** to use.

	var flow = new PantaRhei.Flow( 'myFirstFlow', [task1, task2] );
	
You can also append a worker to the flow passing it  as an argument of the **use** method.

	var task1 = function(shared, next){
			console.log( "task one completed" );
			next();
		},
	flow =  new PantaRhei.Flow( );
	flow.use(task1);
		
To execute the flow you have to invoke the **run** method. The flow can also accept an optional **shared** object. This is passed around to all the workers in the queue and it's returned by the flow on complete, it's actually the place for storing and passing data between workers. If this is not provided the Flow will create a empty object to use. 
	
	// create our workers
	var task1 = function(shared, next){
		shared.data = "the data have been processed"
		next();
	},
	task2 = function(shared, next){
		shared.newData = "we got some new data for you"
		next();
	},
	
	// create our flow and workers passing the first task on the constructor
	flow = new PantaRhei.Flow(  'myFirstFlow', [ task1 ]);
	
	flow
		// append the second task
		.use( task2 )
		// run the flow
		.run({data: "the data is new"});
		
#### Events
PantaRhei make use of the Backbone Events, so the  Flow can dispatch the following events: run, pause, resume, error and complete. Apart from the error all the other events pass the shared object as an argument to the listener.
So to get notified when a flow have been successfully executed you can catch the complete event.
	
	var onComplete = function( shared ){
		console.log(shared);
	};
	
	flow
		.on( 'complete', onComplete)
		.run();

#### Error handling
PantaRhei leave the responsibility to properly handle the errors to you. If any of the worker in the queue pass and error to the next callback, the Flow is paused and dispatch an **error** event. 
Once you have  done with the error handling and you are ready to resume the flow you can call the **resume** method to move to the next worker in the queue.

	var onError = function( err ){
		//handle the error in here
		this.resume();
	};
	
	flow
		.on( 'error', onError)
		.run();

--- 

I hope you will find this useful, if you have questions or suggestion you can reach me via [Twitter](http://twitter.com/FedericoWeber) or [ADN](https://alpha.app.net/federicoweber).

[Gestalt]:http://federicoweber.com/gestaltapp/20120625-142551-pi-3-introducinggestalt

[Backbone.js]:http://backbonejs.org

[Express.js]:http://expressjs.com

[Connect]:http://www.senchalabs.org/connect/

[^1]: If you are looking for an introduction to the use of middle wares in Connect I suggest you to check this short [guide](http://stephensugden.com/middleware_guide/) written by Stephen Sugden.

[^2]:The other one is a simple function that accept as arguments the **shared** object and the **next** callback.

[^3]: More to follow soon.
