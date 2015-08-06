require "spec_helper"

require "frecon/base/object"

describe Object do
	it "has a method :is_an? which is an alias to :is_a?" do
		is_a = Object.method(:is_a?)
		is_an = Object.method(:is_an?)

		case RUBY_VERSION
		when "2.3.0"
			expect(is_an.original_name)
				.to eq(is_a.original_name)
		else
			expect(is_an).to eq(is_a)
		end
	end
end
