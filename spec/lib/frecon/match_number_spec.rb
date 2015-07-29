require "spec_helper"

require "frecon/match_number"

describe FReCon::MatchNumber do
	subject { FReCon::MatchNumber }

	it "responds to the MongoDB compatibility methods" do
		expect(subject).to respond_to(:demongoize)
		expect(subject).to respond_to(:mongoize)
		expect(subject).to respond_to(:evolve)
	end

	describe ".demongoize" do
		subject { FReCon::MatchNumber.method(:demongoize) }

		it "takes one argument" do
			expect(subject.arity).to eq(1)
		end

		context "with a String argument" do
			argument = String.new

			it "does not raise an error" do
				allow(FReCon::MatchNumber).to receive(:new)

				expect { subject.call(argument) }.not_to raise_error
			end
		end

		context "with a Hash argument" do
			argument = Hash.new

			it "raises an ArgumentError" do
				allow(FReCon::MatchNumber).to receive(:new)

				expect { subject.call(argument) }.to raise_error(ArgumentError)
			end
		end
	end

	describe ".mongoize" do
		subject { FReCon::MatchNumber.method(:mongoize) }

		it "takes one argument" do
			expect(subject.arity).to eq(1)
		end
	end

	describe ".evolve" do
		subject { FReCon::MatchNumber.method(:evolve) }

		it "takes one argument" do
			expect(subject.arity).to eq(1)
		end
	end
end
