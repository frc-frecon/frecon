require 'spec_helper'

require 'frecon/base/version'

describe FReCon::Version do
	context 'when representing non-prerelease versions' do
		subject do
			FReCon::Version.new(major: rand(8), minor: rand(8), patch: rand(8))
		end

		it 'produces a version which is RubyGems-compliant' do
			require 'rubygems/version'

			# Manually verify that the string matches the version pattern internally
			# used for checking by RubyGems.
			expect(subject.to_s).to match(Gem::Version::ANCHORED_VERSION_PATTERN)

			# Use the RubyGems validator to manually verify correctness.
			expect(Gem::Version.correct?(subject.to_s)).not_to be(nil)

			# Try to create a RubyGems Version out
			# of the string that Gem::Version generates.
			#
			# This ensures feature-completeness within
			# RubyGems itself.
			expect do
				Gem::Version.new(subject.to_s)
			end.not_to raise_error
		end
	end

	context 'when representing prerelease versions' do
		subject do
			FReCon::Version.new(major: rand(8), minor: rand(8), patch: rand(8), prerelease: 'alpha0')
		end
	end
end

describe FReCon do
	it 'has a version' do
		expect(FReCon.const_get(:VERSION)).to_not be_nil
	end

	it 'has a version which is a FReCon::Version' do
		expect(FReCon.const_get(:VERSION)).to be_a FReCon::Version
	end
end
