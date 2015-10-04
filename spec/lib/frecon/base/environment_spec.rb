require "spec_helper"

require "securerandom"

describe FReCon::Environment do

	subject do
		FReCon::Environment.new(:development)
	end

	describe "#variable" do
		it "returns the current variable" do
			expect(subject.variable).to eq(subject.instance_variable_get(:@variable))
		end
	end

	describe "#variable=" do
		it "takes a symbol and validates it" do
			symbol = SecureRandom.hex.to_sym

			allow(subject).to receive(:validate_symbol)
			expect(subject).to receive(:validate_symbol).with(symbol)
			subject.variable = symbol
		end

		it "takes an invalid symbol and yields an error" do
			symbol = SecureRandom.hex.to_sym

			expect do
				subject.variable = symbol
			end.to raise_error(ArgumentError)
		end

		it "takes an invalid symbol and leaves the variable unset" do
			previous_variable = subject.variable

			symbol = SecureRandom.hex.to_sym

			begin
				subject.variable = symbol
			rescue ArgumentError => e
			end

			expect(subject.variable).to eq(previous_variable)
		end

		before :each do
			subject.instance_variable_set(:@variable, SecureRandom.hex.to_sym)
		end

		[:development, :production, :test].each do |symbol|
			it "takes Symbol #{symbol} and changes the variable" do
				previous_variable = subject.variable

				subject.variable = symbol

				expect(subject.variable).to_not eq(previous_variable)
				expect(subject.variable).to eq(symbol)
			end
		end
	end

end
