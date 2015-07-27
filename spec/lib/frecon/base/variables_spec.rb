require "spec_helper"

require "frecon/base/variables"

describe FReCon do
	it "has a :VERSION constant" do
		expect(FReCon.const_defined?(:VERSION)).to eq(true)
	end

	it "has an instance variable :@environment_variable" do
		expect(FReCon.instance_variable_defined?(:@environment_variable)).to eq(true)
	end

	after :each do
		# Since we might be changing the instance variables that are set when
		# we load this file, re-load it to be on the safe side.
		load "frecon/base/variables.rb"
	end

	describe ".environment" do
		it "returns the environment" do
			expect(FReCon.environment).to eq(FReCon.instance_variable_get(:@environment_variable))
		end
	end

	describe ".environment=" do
		it "sets the environment" do
			previous_environment = FReCon.environment
			new_environment = :production

			FReCon.environment=(new_environment)

			expect(FReCon.environment).to eq(new_environment)
		end
	end
end
