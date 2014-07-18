require "json"
require "frecon/models"

module FReCon
	class DumpController
		def self.full(params)
			competitions = FReCon::Competition.all
			teams = FReCon::Team.all
			matches = FReCon::Match.all
			records = FReCon::Record.all

			{
				"competitions" => competitions,
				"teams" => teams,
				"matches" => matches,
				"records" => records
			}.to_json
		end
	end
end
