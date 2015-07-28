require "spec_helper"

require "frecon/console"

describe FReCon::Console do
	describe ".start" do
		it "sets up the database" do
			allow(FReCon::Database).to receive(:setup)

			expect(FReCon::Database).to receive(:setup).with(FReCon.environment)

			allow(FReCon).to receive(:pry)

			FReCon::Console.start
		end

		context "with pry simulated as missing" do
			it "runs IRB" do
				# Stub require to raise LoadError when the given file argument
				# is "pry".
				allow(FReCon::Console).to receive(:require) do |file|
					if file == "pry"
						raise LoadError, "cannot load such file -- #{file}"
					else
						require file
					end
				end

				expect(FReCon::Console).to receive(:require).with("pry").ordered
				expect(FReCon::Console).to receive(:require).with("irb").ordered

				require "irb"

				allow(IRB).to receive(:conf) { {} }

				expect(IRB).to receive(:setup).with(nil).ordered
				expect(IRB).to receive(:conf).ordered

				FReCon::Console.start
			end
		end
	end
end
