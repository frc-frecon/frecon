require "json"

module FReCon
	class DumpController
		def self.full(params)
			competitions = FReCon::Competition.all.to_a
			teams = FReCon::Team.all.to_a
			matches = FReCon::Match.all.to_a
			records = FReCon::Record.all.to_a

			[200, { "competitions" => competitions, "teams" => teams, "matches" => matches, "records" => records }.to_json]
		end
	end
end
