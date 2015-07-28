require "spec_helper"

require "frecon/controller"

describe FReCon::Controller do
	describe ".model_name" do
		before :all do
			FReCon::TestController = Class.new(FReCon::Controller)
		end

		it "returns the model name for a model" do
			expect(FReCon::TestController.model_name).to eq("Test")
		end

		after :all do
			FReCon.send(:remove_const, :TestController)
		end
	end

	describe ".model" do
		require "frecon/model"

		before :all do
			FReCon::Test = Class.new(FReCon::Model)
			FReCon::TestController = Class.new(FReCon::Controller)
		end

		it "returns the model for a controller" do
			expect(FReCon::TestController.model).to eq(FReCon::Test)
		end

		after :all do
			FReCon.send(:remove_const, :Test)
			FReCon.send(:remove_const, :TestController)
		end
	end
end
