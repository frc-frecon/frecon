require "spec_helper"

require "frecon/base/object"

describe Object do
	it "has a method :is_an? which is an alias to :is_a?" do
		case RUBY_VERSION
		when "2.3.0"
			expect(Object.method(:is_an?).original_name)
				.to eq(Object.method(:is_a?).original_name)
		else
			expect(Object.method(:is_an?)).to eq(Object.method(:is_a?))
		end
	end
end
