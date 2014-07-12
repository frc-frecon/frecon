module FReCon
	class Console
		def self.start
			require "pry"

			Pry.start
		rescue Exception => e
			require "irb"

			IRB.start
		end
	end
end
