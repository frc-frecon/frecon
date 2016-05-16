require 'spec_helper'

describe 'frecon/match_number' do

	it 'can be required without errors' do
		expect { require 'frecon/match_number' }.not_to raise_error
	end

end

require 'frecon/match_number'

describe FReCon::MatchNumber do

	describe '#initialize' do
		context 'taking a String that is properly-formatted' do
			let :string do
				'qf1m3r1'
			end

			it 'does not raise an error about formatting' do
				expect { FReCon::MatchNumber.new(string) }.not_to raise_error
			end
		end

		context 'taking a String that is improperly-formatted' do
			let :string do
				'datoqiwueot'
			end

			it 'raises an error' do
				expect {FReCon::MatchNumber.new(string)}.to raise_error(ArgumentError, 'string is improperly formatted')
			end
		end

		context 'taking a Hash' do
		end

		context 'taking something other than a String or Hash' do
			let :argument do
				JSON::GeneratorError # garbage object, completely useless
			end

			it 'raises an error' do
				expect { FReCon::MatchNumber.new(argument) }.to raise_error(TypeError, 'argument must be a String or Hash')
			end
		end
	end

end
