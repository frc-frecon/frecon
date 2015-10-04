require "spec_helper"

describe FReCon do
	it "has a version" do
 		expect(FReCon.const_get(:VERSION)).to_not be_nil
 		expect(FReCon.const_get(:VERSION)).to be_a String
	end

	describe ".environment" do
		it "takes no arguments and returns the current environment" do
			expect(FReCon.environment)
				.to eq(FReCon.instance_variable_get(:@environment_variable))
		end
	end

	describe ".environment=" do
		original = nil

		before :all do
			original = FReCon.instance_variable_get(:@environment_variable)
		end

		it "takes an argument and sets the current environment" do
			sample_environment = :sample_environment

			FReCon.environment = sample_environment

			expect(FReCon.instance_variable_get(:@environment_variable))
				.to eq(sample_environment)

		end

		after :all do
			FReCon.instance_variable_set(:@environment_variable, original)
		end
	end
end
