require 'spec_helper'

describe 'frecon/match_number' do

	it 'can be required without errors' do
		expect { require 'frecon/match_number' }.not_to raise_error
	end

end

require 'frecon/match_number'

describe FReCon::MatchNumber do
	let :nonrounded_type_string do
		%w.p q..sample
	end

	let :rounded_type_string do
		%w.qf sf f..sample
	end

	let :generic_type_string do
		[nonrounded_type_string, rounded_type_string].sample
	end

	let :nonrounded_type_symbol do
		case nonrounded_type_string
		when 'p'
			:practice
		when 'q'
			:qualification
		else
			raise "unexpected nonrounded_type_string #{nonrounded_type_string}, cannot parse"
		end
	end

	let :rounded_type_symbol do
		case rounded_type_string
		when 'qf'
			:quarterfinal
		when 'sf'
			:semifinal
		when 'f'
			:final
		else
			raise "unexpected rounded_type_string #{rounded_type_string}, cannot parse"
		end
	end

	let :generic_type_symbol do
		case generic_type_string
		when 'p'
			:practice
		when 'q'
			:qualification
		when 'qf'
			:quarterfinal
		when 'sf'
			:semifinal
		when 'f'
			:final
		else
			raise "unexpected generic_type_string #{generic_type_string}, cannot parse"
		end
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

	# Each of these arrays of atoms represents a case we are testing for;
	# the presence of each of these tests
	[[:rounded_type, :round, :number, :replay_number],
	 [:rounded_type, :round, :number],
	 [:nonrounded_type, :number],
	 [:nonrounded_type, :number, :replay_number]].each do |slug|
		array_of_readable_field_names = slug.map do |field_name|
			case field_name
			when :generic_type
				"generic type"
			when :rounded_type
				"rounded type"
			when :nonrounded_type
				"rounded type"
			when :round
				"round number"
			when :number
				"match number"
			when :replay_number
				"replay number"
			end
		end

		# TODO: Interpolated string
		human_readable_context = 'with a ' +
			array_of_readable_field_names[0..-2].join(', ') +
			', and ' +
			array_of_readable_field_names[-1]

		context human_readable_context do
			slug_type = slug.include?(:type) ? :generic :
				slug.include?(:rounded_type) ? :rounded :
				slug.include?(:nonrounded_type) ? :nonrounded : nil

			slug_has_round = slug.include?(:round)
			slug_has_number = slug.include?(:number)
			slug_has_replay_number = slug.include?(:replay_number)

			let(:_type_symbol) {
				case slug_type
				when :generic
					generic_type_symbol
				when :rounded
					rounded_type_symbol
				when :nonrounded
					nonrounded_type_symbol
				else
					nil
				end
			}

			let(:_type_string) {
				case slug_type
				when :generic
					generic_type_string
				when :rounded
					rounded_type_string
				when :nonrounded
					nonrounded_type_string
				else
					nil
				end
			}

			let(:_round) {
				slug_has_round ? round : nil
			}

			let(:_number) {
				slug_has_number ? number : nil
			}

			let(:_replay_string) {
				slug_has_replay_number ? "r#{replay_number}" : nil
			}

			describe '.parse' do
				context 'taking a properly-formatted String representation' do
					subject { FReCon::MatchNumber.parse(string) }

					let(:string) { "#{_type_string}#{_round}m#{_number}#{_replay_string}" }

					let(:_expected_type) {
						_type_symbol
					}

					it 'does not raise an error' do
						expect { subject }.not_to raise_error
					end

					case slug_type
					when :generic
						it 'properly parses the (generic) type of the match' do
							expect(subject).to have_type(_expected_type)
						end
					when :rounded
						it 'properly parses the (rounded) type of the match' do
							expect(subject).to have_rounded_type(_expected_type)
						end
					when :nonrounded
						it 'properly parses the (nonrounded) type of the match' do
							expect(subject).to have_nonrounded_type(_expected_type)
						end
					when nil
						it 'parses no type for the match' do
							expect(subject).not_to have_type
						end
					end

					if slug_has_round
						it 'properly parses the round number of the match' do
							expect(subject).to have_round_number(_round)
						end
					else
						it 'parses no round number for the match' do
							expect(subject).not_to have_round_number
						end
					end

					if slug_has_number
						it 'properly parses the number of the match' do
							expect(subject).to have_number(_number)
						end
					else
						it 'parses no number for the match' do
							expect(subject).not_to have_number
						end
					end

					if slug_has_replay_number
						it 'properly parses the replay number of the match' do
							expect(subject).to have_replay_number(replay_number)
						end
					else
						it 'parses no replay number for the match' do
							expect(subject).not_to have_replay_number
						end
					end
				end
			end

			describe '.from_hash' do
				context 'taking a Hash' do
					subject { FReCon::MatchNumber.from_hash(hash) }

					let(:hash) {
						hash = {}
						hash['type'] = _type_symbol if !!slug_type
						hash['round'] = _round if !!slug_has_round
						hash['number'] = _number if !!slug_has_number
						hash['replay_number'] = replay_number if !!slug_has_replay_number
						hash
					}

					let(:_expected_type) {
						_type_symbol
					}

					it 'does not raise an error' do
						expect { subject }.not_to raise_error
					end

					case slug_type
					when :generic
						it 'properly sets the (generic) type of the match' do
							expect(subject).to have_type(_expected_type)
						end
					when :rounded
						it 'properly sets the (rounded) type of the match' do
							expect(subject).to have_rounded_type(_expected_type)
						end
					when :nonrounded
						it 'properly sets the (nonrounded) type of the match' do
							expect(subject).to have_nonrounded_type(_expected_type)
						end
					when nil
						it 'does not set a type for the match' do
							expect(subject).not_to have_type
						end
					end

					if slug_has_round
						it 'properly parses the round number of the match' do
							expect(subject).to have_round_number(_round)
						end
					else
						it 'parses no round number for the match' do
							expect(subject).not_to have_round_number
						end
					end

					if slug_has_number
						it 'properly parses the number of the match' do
							expect(subject).to have_number(_number)
						end
					else
						it 'parses no number for the match' do
							expect(subject).not_to have_number
						end
					end

					if slug_has_replay_number
						it 'properly parses the replay number of the match' do
							expect(subject).to have_replay_number(replay_number)
						end
					else
						it 'parses no replay number for the match' do
							expect(subject).not_to have_replay_number
						end
					end
				end
			end
		end
	end

	describe '.parse' do
		subject { FReCon::MatchNumber.parse(string) }

		context 'with a valid type, and 0 as the number' do
			let(:_type) { generic_type_string }
			let(:_number) { 0 }
			let(:string) { "#{_type}m#{_number}" }

			it 'raises an ArgumentError, "match number must be greater than 0"' do
				expect { subject }.to raise_error(ArgumentError, 'match number must be greater than 0')
			end
		end

		context 'with a valid rounded type, valid number, and 0 as the round number' do
			let(:_type) { rounded_type_string }
			let(:_number) { number }
			let(:_round) { 0 }
			let(:string) { "#{_type}#{_round}m#{_number}" }

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
end
