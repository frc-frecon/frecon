require "spec_helper"

require "frecon/base/bson"

describe "BSON::ObjectId" do
	describe "#as_json" do
		context "with no arguments" do
			it "returns just the value of a BSON::ObjectId" do
				# Create an OID from the current time.
				oid = BSON::ObjectId.from_time(Time.now)

				# Pass the arguments to the function and expect it to
				expect(oid.as_json).to eq(oid.to_s)
			end
		end
	end
end
