require 'spec_helper'

describe 'lib/frecon.rb' do

	it 'can be required with no error' do
		expect { require 'frecon' }.not_to raise_error
	end

end
