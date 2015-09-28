---
title: Migrating from Amazon EC2 to Nodejitsu PaaS
---
Last year I decided to renew my website, and cause I was also studying Node.js I decided to develop from scratch the publishing platform—you can read more about it in [here](http://federicoweber.com/gestaltapp/20120625-142551-pi-3-introducinggestalt)—and self host it on Amazon EC2 to get a grip on the platform. 

As my first attempt to self manage a server, setting up the EC2 instance was far from an easy task for me. It took me a couple of days of studying official documentation and tutorials to successfully setup the EC2 instance, deploy Gestalt via GIT and have the server run it as a demon. 

During this time, while Gestalt grown in capabilities and performance, I discovered myself to be a terrible SisAdmin. Therefor when I received the notification that my free tier[^1] was about to expire I quickly decided to migrate everything to a managed platform where my only concern would bee to work on the Gestalt.

Looking for the perfect match for my needs I decided to give a try at [Nodejitsu's Platform as a Service](http://nodejitsu.com/paas.html) (Paas)—being attracted from their convenient fees, with the cheapest plan, for individuals, starting at $3 a month. 
Prepared for a long and painful migration I created an account studied their documentation, installed jitsu CLI via npm and in **less then 10 minutes** Gestalt was running smoothly from their servers. Once I've been sure that everything was stable I update the DNS records and shutted down  the EC2 instance.

It's early for me to comment on their service reliability, but with such a pleasant startup I can not help but recommend their service.

---

I hope you found this useful if you have questions or comments feel free to contact me on [Twitter](http://twitter.com/FedericoWeber) or [ADN](https://alpha.app.net/federicoweber).


[^1]:During this time (from February 28 2012) I've been able to use their services for free leveraging the [Free Tier Period](http://aws.amazon.com/free/faqs/) 