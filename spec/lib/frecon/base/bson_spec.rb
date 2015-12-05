require "spec_helper"

require "frecon/base/bson"

describe BSON::ObjectId do
	subject do
		BSON::ObjectId.new
	end

	describe "#as_json" do
		it "takes no arguments and returns the string representation of the ID" do
			expect(subject.as_json).to eq(subject.to_s)
		end
	end
end
