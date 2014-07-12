Gem::Specification.new do |s|
	s.name = "frecon"
	s.email = "sammidysam@gmail.com"
	s.version = "0.0.0"
	
	s.summary = "A JSON API for scouting FRC competitions."
	s.description = "A JSON API for scouting FRC competitions that manages the database for the user."
	
	s.authors = ["Sam Craig",
	             "Kristofer Rye",
	             "Christopher Cooper"]

	s.homepage = "https://github.com/scouting-project/scouting-project"
	s.files = Dir.glob("lib/**/*.rb") << "lib/mongoid.yml"
end
