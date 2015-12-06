require 'spec_helper'

describe FReCon do
	it 'has a version' do
 		expect(FReCon.const_get(:VERSION)).to_not be_nil
 		expect(FReCon.const_get(:VERSION)).to be_a String
	end

	it 'has an environment' do
 		expect(FReCon.const_get(:ENVIRONMENT)).to_not be_nil
 		expect(FReCon.const_get(:ENVIRONMENT)).to be_a FReCon::Environment
	end
end
