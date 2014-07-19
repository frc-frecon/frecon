require "json"
require "frecon/models"

module FReCon
	class DumpController
		def self.full(params)
			competitions = Competition.all
			teams = Team.all
			matches = Match.all
			records = Record.all

			{
				"competitions" => competitions,
				"teams" => teams,
				"matches" => matches,
				"records" => records
			}.to_json
		end
	end
end
