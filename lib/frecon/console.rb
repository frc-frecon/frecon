module FReCon
	class Console
		def self.start
			FReCon::Database.setup(FReCon::Server.environment)

			begin
				require "pry"
				
				FReCon.pry
			rescue Exception
				require "irb"

				IRB.setup nil
				IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context

				require "irb/ext/multi-irb"

				IRB.irb nil, FReCon
			end
		end
	end
end
