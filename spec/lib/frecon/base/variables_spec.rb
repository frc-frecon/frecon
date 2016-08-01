require 'spec_helper'

require 'frecon/base/variables'

describe FReCon do
	it 'has a version' do
		expect(FReCon.const_get(:VERSION)).to_not be_nil
		expect(FReCon.const_get(:VERSION)).to be_a FReCon::Version
	end

	it 'has an environment' do
 		expect(FReCon.const_get(:ENVIRONMENT)).to_not be_nil
	end
end
