require 'spec_helper'

require 'frecon/match_number'

describe FReCon::MatchNumber do

	describe '#initialize' do
		context 'given a String that is properly formatted' do
		end

		context 'given a String that is improperly formatted' do
			let(:string) do
				'dank memes'
			end

			it 'raises an error' do
				expect { FReCon::MatchNumber.new string }.to raise_error(ArgumentError, 'string is improperly formatted')
			end
		end
	end

end
