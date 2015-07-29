# FReCon

FReCon is an API for scouting at *FIRST* Robotics competitions.
It is designed to be game-agnostic, that is, as dynamic as possible from year to year.

FReCon is built in Ruby, using Sinatra for the foundations of a server and the Mongoid database backend to interface with MongoDB as our system-level database backend.
You need to have Ruby installed before you can use FReCon.
We highly recommend using [rvm][rvm] to achieve this.

## Getting Started

```sh
$ gem install frecon
```

You can install FReCon through RubyGems by running the above command.
You can also include `gem "frecon"` in your `Gemfile`, if you're writing a Ruby project using Bundler that has FReCon as a dependency.
However, FReCon will not work unless some [System Dependencies](#system-dependencies) are installed.

## Basic Usage

```sh
$ frecon
```

This command starts the FReCon API as its own server on your device.

```sh
$ frecon console
$ frecon c
```

Both of these commands start a FReCon console.
A FReCon console is simply a [pry](https://github.com/pry/pry) shell that allows you to type `Team` instead of `FReCon::Team` to access that class.
It is more convenient than loading FReCon into an existing pry or irb session.

## System Dependencies

* **MongoDB**
  - On Fedora, you can install MongoDB with `yum install mongodb mongodb-server`, and start it with `service mongod start`.
  - No configuration should be necessary; the packaged version of MongoDB works just fine.

## Architecture

FReCon is written as a JSON API.
This means that it returns responses which can be parsed via `JSON.parse` in JavaScript or the corresponding function in a different language.
You can also interact with FReCon directly from the console, which is mentioned in the [Quick Usage section](#quick-usage).

As it is written in Ruby, FReCon *should* run on Mac OSX/Linux without much trouble.
Windows users of FReCon may need to do a bit of fenangling, but we'd love to work with you if you're trying to use FReCon on Windows and need help.
As a result of your effort, we could make a tutorial for future users.

## Implementation

The project is split up into models and controllers, housed in their respective folders.
When you start the server, all these files are loaded.
When you make a query, the server checks to see what do in `routes.rb`.
That usually directs it to a controller, which does some logic and may access one or more models before returning the content of the page requested, which is then sent to the client.

## Testing

This project uses Guard and RSpec for testing.
As you refactor, or wish to check the status of the project, you can start Guard to continuously test your changes and notify you about your test results.

```sh
$ bundle exec guard
```

If you prefer to simply run the spec manually, you can run the entire spec manually.

```sh
$ bundle exec rspec
```

When you write new features that should be tested, please do add them to the suite.
Likewise, if you find a feature that isn't tested, please add it to the suite.

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
