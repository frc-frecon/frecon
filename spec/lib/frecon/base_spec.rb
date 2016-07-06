require 'spec_helper'

describe 'lib/frecon/base.rb' do

	it 'can be required with no error' do
		expect { require 'frecon/base' }.not_to raise_error
	end

end
