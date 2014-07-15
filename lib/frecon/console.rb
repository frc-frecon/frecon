module FReCon
	class Console
		def self.start
			FReCon::Database.setup(FReCon::Server.environment)

			# Use pry if it is installed.
			# Use the context of the FReCon module;
			# this allows for writing "Team" instead of "FReCon::Team".
			begin
				require "pry"
				
				FReCon.pry
			rescue LoadError
				require "irb"

				IRB.setup nil
				IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context

				require "irb/ext/multi-irb"

				IRB.irb nil, FReCon
			end
		end
	end
end
