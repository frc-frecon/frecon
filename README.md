# scouting-project

## How to get started

It's highly recommended that you use [rvm](http://rvm.io).
Just run the command on the front of their website.
It's much easier than installing Ruby via a package manager.

Once you've done that, run `gem install bundler`.
Gems are Ruby packages, and bundle will take care of installing all the other ones.
To do that, cd to the project directory and run `bundle install`.

Great! You are pretty much ready to go now.
Run `ruby server.rb` to run the server, and access it at localhost:4567.
If you want an interactive console in the server environment, just run `ruby console.rb`.

Get to work!

## How stuff works

Right now, the project is split up into models and controllers, housed in their respective folders.
When you start the server, all these files are loaded, and the database is updated to make sure it matches what properties are defined in the models.
When you make a query, the server checks to see what do in `routes.rb`.
That usually directs it to a controller, which does some logic and may access one or more models before returning the content of the page requested, which is then sent to the client.
