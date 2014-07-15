require "pry"

module FReCon
	class Console
		def self.start
			FReCon::Database.setup(FReCon::Server.environment)

			FReCon.pry
		end
	end
end
