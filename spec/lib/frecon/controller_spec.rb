require "spec_helper"

require "frecon/controller"

describe FReCon::Controller do
	before :all do
		FReCon::Test = Class.new(FReCon::Model)
		FReCon::TestController = Class.new(FReCon::Controller)
	end

	describe ".model_name" do
		it "returns the model name for a model" do
			expect(FReCon::TestController.model_name).to eq("Test")
		end
	end

	describe ".model" do
		it "returns the model for a controller" do
			expect(FReCon::TestController.model).to eq(FReCon::Test)
		end
	end

	describe ".find_model" do
		it "takes a single params argument and executes a find on the model class" do
			id = BSON::ObjectId.from_time(Time.now)

			params = {"id" => id}

			allow(FReCon::Test).to receive(:find)
			expect(FReCon::Test).to receive(:find).with(id)

			FReCon::TestController.find_model(params)
		end
	end

	describe ".could_not_find" do
		context "with one argument" do
			it "returns a correct message" do
				value = "value"
				expect(FReCon::TestController.could_not_find(value))
					.to eq("Could not find test of id #{value}!")
			end
		end

		context "with two arguments" do
			it "returns a correct message" do
				value, attribute = %w[value attribute]

				expect(FReCon::TestController.could_not_find(value, attribute))
					.to eq("Could not find test of #{attribute} #{value}!")
			end
		end

		context "with three arguments" do
			it "returns a correct message" do
				value, attribute, model = %w[value attribute model]
				expect(FReCon::TestController.could_not_find(value, attribute, model))
					.to eq("Could not find #{model} of #{attribute} #{value}!")
			end
		end
	end

	after :all do
		FReCon.send(:remove_const, :Test)
		FReCon.send(:remove_const, :TestController)
	end
end
