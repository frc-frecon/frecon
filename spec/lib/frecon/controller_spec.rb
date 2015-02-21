require "spec_helper"

require "frecon/controller"

describe FReCon::Controller do
	[:model_name, :model, :could_not_find, :process_request].each do |method_name|
		it "has a class method #{method_name.to_s}" do
			expect(FReCon::Controller.respond_to?(method_name)).to be(true)
		end
	end

	[:create, :update, :delete, :show, :index, :show_attribute, :team_number_to_team_id].each do |method_name|
		it "has a method #{method_name.to_s} <used for response>" do
			expect(FReCon::Controller.respond_to?(method_name)).to be(true)
		end
	end

	it "has access to JSON" do
		expect(FReCon::Controller.ancestors).to include(JSON::Ext::Generator::GeneratorMethods::Object)
	end

	it "has access to Mongoid" do
		expect(FReCon::Controller.ancestors).to include(Mongoid::Extensions::Object)
	end

	describe :model_name do
		it "works on a new class that inherits 'FReCon::Controller' but out of FReCon module" do
			class TestController < FReCon::Controller
			end

			expect(TestController.model_name).to eq("Test")
		end

		it "works on a new class that inherits 'FReCon::Controller' and in FReCon module" do
			module FReCon
				class TestController < FReCon::Controller
				end
			end

			expect(FReCon::TestController.model_name).to eq("Test")
		end
	end

	describe :model do
		it "does not work on a new class that inherits 'FReCon::Controller' and is in FReCon module but does not have a sibling model that matches the name" do
			module FReCon
				class TestController < FReCon::Controller
				end
			end

			expect { FReCon::TestController.model }.to raise_error
		end

		it "works on a new class that inherits 'FReCon::Controller' and is in FReCon module" do
			module FReCon
				class Test < FReCon::Model
				end

				class TestController < FReCon::Controller
				end
			end

			expect(FReCon::TestController.model).to eq(FReCon::Test)
		end
	end

	describe :could_not_find do
		it "creates correct string message given varying arguments" do
			[[SecureRandom.base64], [SecureRandom.base64, SecureRandom.base64], [SecureRandom.base64, SecureRandom.base64, SecureRandom.base64]].each do |arguments|
				module FReCon
					class Test < FReCon::Model
					end

					class TestController < FReCon::Controller
					end
				end

				expect(FReCon::TestController.send(:could_not_find, *arguments)).to eq("Could not find #{FReCon::TestController.model_name.downcase} of #{arguments.length >= 2 ? arguments[1] : "id"} #{arguments[0]}!")
			end
		end
	end
end
