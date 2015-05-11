# FReCon

FReCon is an API for scouting at *FIRST* Robotics competitions.
It is designed to be game-agnostic, that is, as dynamic as possible from year to year.
We, the developers, have crafted FReCon to be as widely-usable as possible.

FReCon is built in Ruby, using the Mongoid database backend to interface with MongoDB as our system-level database backend.
You need to have Ruby installed before you can use FReCon.
We highly recommend using [rvm][rvm] to achieve this.

## Getting Started

```sh
$ gem install frecon
```

You can install FReCon through RubyGems by running the above command.
You can also include `gem "frecon"` in your `Gemfile`, if you're writing a derivative Ruby project.
However, FReCon will not work unless some [System Dependencies](#system-dependencies) are installed.

## Basic Usage

```sh
$ frecon
```

This command starts the FReCon API as its own server on your device.


## System Dependencies

* **MongoDB**
  - On Fedora, you can install MongoDB like `yum install mongodb mongodb-server`, and start it like `service mongod start`.
  - No configuration should be necessary; the packaged version of MongoDB works just fine.

## Architecture

FReCon is written as a JSON API.
This means that it returns responses which are quickly parsed in JavaScript via `JSON.parse`.
You can also interact with FReCon directly from the console&mdash;look for documentation below.

As it is written in Ruby, FReCon should *run* on Mac OSX/Linux without much trouble.
Windows users of FReCon may need to do a bit of fenangling, but we'd love to work with you if you're trying to use FReCon on Windows and need help.

## How stuff works

Right now, the project is split up into models and controllers, housed in their respective folders.
When you start the server, all these files are loaded, and the database is updated to make sure it matches what properties are defined in the models.
When you make a query, the server checks to see what do in `routes.rb`.
That usually directs it to a controller, which does some logic and may access one or more models before returning the content of the page requested, which is then sent to the client.

## License

FReCon is distributed under the terms of the MIT license.
You should have received a copy of the MIT license with this program.
If not, you can find a copy at [opensource.org/licenses/mit][mit].
You can also contact us with any licensing concerns or requests for permission at [frc-frecon@googlegroups.com][frc-frecon-mail].
(Or, if email bounces from there, you may contact Kristofer Rye at [kristofer.rye@gmail.com][kristofer-rye-mail])

[rvm]: http://rvm.io
[ruby]: https://www.ruby-lang.org/en/
[mit]: http://opensource.org/license/mit
[frc-frecon-mail]: mailto:frc-frecon@googlegroups.com
[kristofer-rye-mail]: mailto:kristofer.rye@gmail.com
