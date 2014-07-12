module FReCon
	class Console
		def self.start
			FReCon::Database.setup(FReCon::Server.environment)
			
			begin
				require "pry"

				Pry.start
			rescue Exception => e
				require "irb"

				IRB.start
			end
		end
	end
end
