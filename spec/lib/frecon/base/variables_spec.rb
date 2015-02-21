require "spec_helper"

require "frecon/base/variables"

describe FReCon do
	describe FReCon::VERSION do
		it "is a constant" do
			expect(FReCon.constants).to include(:VERSION)
		end

		it "is a string" do
			expect(FReCon.const_get(:VERSION)).to be_a(String)
		end
	end

	describe FReCon do
		it "has an :environment method" do
			expect(FReCon.methods).to include(:environment)
		end

		it "has an :environment= method" do
			expect(FReCon.methods).to include(:environment=)
		end

		it "has an :@environment_variable instance variable" do
			expect(FReCon.instance_variables).to include(:@environment_variable)
		end

		describe "FReCon.environment" do
			it "returns current environment" do
				random_environment = SecureRandom.hex(64).to_sym

				FReCon.instance_variable_set(:@environment_variable, random_environment)

				expect(FReCon.environment).to be(random_environment)
			end
		end

		describe "FReCon.environment=" do
			it "sets environment variable to new environment variable" do
				random_environment = SecureRandom.hex(64).to_sym

				FReCon.environment = random_environment

				expect(FReCon.instance_variable_get(:@environment_variable)).to be(random_environment)
			end
		end
	end
end
