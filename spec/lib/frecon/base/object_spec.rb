require "spec_helper"

require "frecon/base/object"

describe Object do 
	it "has :is_an? method alias" do
		expect(Object.new.respond_to?(:is_an?)).to be(true)
	end
end
