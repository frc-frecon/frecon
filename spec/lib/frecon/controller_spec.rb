require "spec_helper"

describe FReCon::Controller do
	[:model_name, :model, :could_not_find, :process_request].each do |method_name|
		it "has a method #{method_name.to_s}" do
			expect(FReCon::Controller.respond_to?(method_name)).to be_true
		end
	end

	[:create, :update, :delete, :show, :index, :show_attribute].each do |method_name|
		it "has a method #{method_name.to_s} <used for response>" do
			expect(FReCon::Controller.respond_to?(method_name)).to be_true
		end
	end

	it "has access to JSON" do
		expect(FReCon::Controller.ancestors).to include(JSON::Ext::Generator::GeneratorMethods::Object)
	end

	it "has access to Mongoid" do
		expect(FReCon::Controller.ancestors).to include(Mongoid::Extensions::Object)
	end
end
