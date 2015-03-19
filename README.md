# FReCon

FReCon is an API for scouting at *FIRST* Robotics competitions.
It is designed to be game-agnostic, that is, as dynamic as possible from year to year.
We, the developers, have crafted FReCon to be as widely-usable as possible.

FReCon is built in Ruby, using the Mongoid database backend to interface with MongoDB as our system-level database backend.

## Architecture

FReCon is written as a JSON API.
This means that it returns responses which are quickly parsed in JavaScript via `JSON.parse`.
You can also interact with FReCon directly from the console&mdash;look for documentation below.

As it is written in Ruby, FReCon should *run* on Mac OSX/Linux without much trouble.
Windows users of FReCon may need to do a bit of fenangling, but we'd love to work with you if you're trying to use FReCon on Windows and need help.

## System Dependencies

* **MongoDB**
  - On Fedora, you can install MongoDB like `yum install mongodb mongodb-server`, and start it like `service mongod start`.
  - No configuration should be necessary; the packaged version of MongoDB works just fine.

* **Ruby**
  - It's highly recommended that you use [rvm][rvm] or install Ruby from source.
    - To use rvm, just follow the instructions on the front of their website.
    - To install from source instead, download the tarball from [the Ruby website][ruby].


## How to get started

### Ruby

It's highly recommended that you use [rvm](http://rvm.io).
Just run the command on the front of their website.
It's much easier than installing Ruby via a package manager.

Once you've done that, run `gem install bundler`.
Gems are Ruby packages, and bundle will take care of installing all the other ones.
To do that, cd to the project directory and run `bundle install`.

Great! You are pretty much ready to go now.
Run `bin/frecon` to run the server, and access it at localhost:4567.
If you want an interactive console in the server environment, just run `bin/frecon console`.

Get to work!

## How stuff works

Right now, the project is split up into models and controllers, housed in their respective folders.
When you start the server, all these files are loaded, and the database is updated to make sure it matches what properties are defined in the models.
When you make a query, the server checks to see what do in `routes.rb`.
That usually directs it to a controller, which does some logic and may access one or more models before returning the content of the page requested, which is then sent to the client.

## License

FReCon is distributed under the terms of the MIT license.
You should have received a copy of the MIT license with this program.
If not, you can find a copy at [opensource.org/licenses/mit](http://opensource.org/licenses/mit).

[rvm]: http://rvm.io
[ruby]: https://www.ruby-lang.org/en/
