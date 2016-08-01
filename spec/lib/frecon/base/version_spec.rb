require 'spec_helper'

require 'frecon/base/version'

describe FReCon do
	it 'has a version' do
		expect(FReCon.const_get(:VERSION)).to_not be_nil
	end

	it 'has a version which is a FReCon::Version' do
		expect(FReCon.const_get(:VERSION)).to be_a FReCon::Version
	end
end
