require 'spec_helper'

require 'frecon/console'

describe FReCon::Console do
	describe '.start' do
		it 'takes keyword arguments, starts the database, and calls FReCon.pry' do
			allow(FReCon::Database).to receive(:setup!)
			expect(FReCon::Database).to receive(:setup!)

			allow(FReCon).to receive(:pry)
			expect(FReCon).to receive(:pry)

			expect(FReCon::Console).to receive(:require).with('pry')

			FReCon::Console.start
		end
	end
end
