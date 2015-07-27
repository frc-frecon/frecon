require "spec_helper"

require "frecon/base/object"

describe Object do
	it "has a method :is_an? which is an alias to :is_a?" do
		expect(Object.method(:is_an?)).to eq(Object.method(:is_a?))
	end
end
