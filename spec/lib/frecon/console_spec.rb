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

		it "uses pry" do
			allow(FReCon::Console).to receive(:require)
			allow(FReCon).to receive(:pry)

			expect(FReCon::Console).to receive(:require).with("pry").ordered
			expect(FReCon).to receive(:pry).ordered

			FReCon::Console.start
		end
	end
end
