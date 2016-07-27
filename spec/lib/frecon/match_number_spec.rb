require 'spec_helper'

describe 'frecon/match_number' do

	it 'can be required without errors' do
		expect { require 'frecon/match_number' }.not_to raise_error
	end

end

require 'frecon/match_number'

describe FReCon::MatchNumber do

	describe '#initialize' do
		context 'given a String' do
			subject { FReCon::MatchNumber.new(string) }

			let :nonrounded_type do
				%w.p q..sample
			end

			let :rounded_type do
				%w.qf sf f..sample
			end

			let :round do
				rand(32768) + 1 # add 1 to ensure not 0
			end

			let :number do
				rand(32768) + 1 # add 1 to ensure not 0
			end

			let :replay_number do
				rand(32768) + 1 # add 1 to ensure not 0
			end

			let :improperly_formatted_string do
				'dank memes'
			end

			context 'with a rounded type, round, number, and replay_number' do
				let(:string) { "#{rounded_type}#{round}m#{number}r#{replay_number}" }

				it 'does not raise an error' do
					expect { subject }.not_to raise_error
				end

				it 'parses the type to a Symbol' do
					expect(subject.type).to be_a(Symbol)
				end

				it 'properly parses the type of the match' do
					expected_type = case rounded_type
					                when 'qf'
						                :quarterfinal
					                when 'sf'
						                :semifinal
					                when 'f'
						                :final
					                end

					expect(subject.type).to eq(expected_type)
				end

				it 'properly parses the number of the match' do
					expect(subject.number).to eq(number)
				end

				it 'properly parses the round number of the match' do
					expect(subject.round).to eq(round)
				end

				it 'properly parses the replay number of the match' do
					expect(subject.replay_number).to eq(replay_number)
				end
			end

			context 'with a rounded type, round, and number' do
				let(:string) { "#{rounded_type}#{round}m#{number}" }

				it 'does not raise an error' do
					expect { subject }.not_to raise_error
				end

				it 'parses the type to a Symbol' do
					expect(subject.type).to be_a(Symbol)
				end

				it 'properly parses the type of the match' do
					expected_type = case rounded_type
					                when 'qf'
						                :quarterfinal
					                when 'sf'
						                :semifinal
					                when 'f'
						                :final
					                end

					expect(subject.type).to eq(expected_type)
				end

				it 'properly parses the number of the match' do
					expect(subject.number).to eq(number)
				end

				it 'properly parses the round number of the match' do
					expect(subject.round).to eq(round)
				end

				it 'does not parse a replay number for the match' do
					expect(subject.replay_number).to be(nil)
				end
			end

			context 'with a nonrounded type, number, and replay_number' do
				let(:string) { "#{nonrounded_type}m#{number}r#{replay_number}" }

				it 'does not raise an error' do
					expect { subject }.not_to raise_error
				end

				it 'parses the type to a Symbol' do
					expect(subject.type).to be_a(Symbol)
				end

				it 'properly parses the type of the match' do
					expected_type = case nonrounded_type
					                when 'p'
						                :practice
					                when 'q'
						                :qualification
					                end

					expect(subject.type).to eq(expected_type)
				end

				it 'properly parses the number of the match' do
					expect(subject.number).to eq(number)
				end

				it 'does not parse a round for the match' do
					expect(subject.round).to be(nil)
				end

				it 'properly parses the replay number of the match' do
					expect(subject.replay_number).to eq(replay_number)
				end
			end

			context 'with a nonrounded type, and number' do
				let(:string) { "#{nonrounded_type}m#{number}" }

				it 'does not raise an error' do
					expect { subject }.not_to raise_error
				end

				it 'parses the type to a Symbol' do expect(subject.type).to be_a(Symbol) end

				it 'properly parses the type of the match' do
					expected_type = case nonrounded_type
					                when 'p'
						                :practice
					                when 'q'
						                :qualification
					                end

					expect(subject.type).to eq(expected_type)
				end

				it 'properly parses the number of the match' do
					expect(subject.number).to eq(number)
				end

				it 'does not parse a round for the match' do
					expect(subject.round).to be(nil)
				end

				it 'does not parse a replay number for the match' do
					expect(subject.replay_number).to be(nil)
				end
			end

			context 'with a valid type, and 0 as the number' do
				let(:type) { [nonrounded_type, rounded_type].sample }
				let(:string) { "#{type}m0" }

				it 'raises an ArgumentError, "match number must be greater than 0"' do
					expect { subject }.to raise_error(ArgumentError, 'match number must be greater than 0')
				end
			end

			context 'with a valid rounded type, valid number, and 0 as the round number' do
				let(:type) { [rounded_type].sample }
				let(:string) { "#{type}0m#{number}" }

				it 'raises an ArgumentError, "round number must be greater than 0"' do
					expect { subject }.to raise_error(ArgumentError, 'round number must be greater than 0')
				end
			end

			context 'that is improperly formatted' do
				let(:string) { improperly_formatted_string }

				it 'raises an ArgumentError, "string is improperly formatted"' do
					expect { subject }.to raise_error(ArgumentError, 'string is improperly formatted')
				end
			end
		end

		context 'given a Hash' do
		end

	end

end
