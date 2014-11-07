lib_directory = File.class_eval('expand_path(join(dirname(__FILE__), "lib"))')
$LOAD_PATH.unshift(lib_directory) unless $LOAD_PATH.include?(lib_directory)

require "frecon/base/variables"

Gem::Specification.new do |s|
	s.name = "frecon"
	s.email = "frc-frecon@googlegroups.com"
	s.version = FReCon::VERSION

	s.summary = "A JSON API for scouting FRC competitions."
	s.description = "A JSON API for scouting FRC competitions that manages the database for the user."

	s.authors = ["Sam Craig",
	             "Kristofer Rye",
	             "Christopher Cooper",
	             "Sam Mercier",
	             "Tiger Huang",
	             "Vincent Mai"]

	s.homepage = "https://github.com/frc-frecon/frecon"
	s.files = Dir.glob("lib/**/*.rb") << "lib/frecon/mongoid.yml" << "bin/frecon"
	s.executables << "frecon"

	s.add_runtime_dependency "sinatra", ["~> 1.4"]
	s.add_runtime_dependency "thin", ["~> 1.6"]
	s.add_runtime_dependency "mongoid", ["~> 4.0"]
end
