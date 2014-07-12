module FReCon
	module Console
		def start
			require "pry"

			Pry.start
		rescue Exception => e
			require "irb"

			IRB.start
		end
	end
end
