require 'spec_helper'

require 'frecon/database'

describe FReCon::Database do
	describe '.setup!' do
		it 'calls Mongoid.load! with a String (filename) and a Symbol' do
			allow(Mongoid).to receive(:load!).with(String, Symbol)
			expect(Mongoid).to receive(:load!).with(String, Symbol)

			FReCon::Database.setup!
		end
	end
end
