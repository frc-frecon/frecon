require 'spec_helper'

require 'frecon/console'

describe FReCon::Console do
	describe '.start' do
		it 'calls FReCon::Database.setup!' do
			allow(FReCon::Database).to receive(:setup!)
			expect(FReCon::Database).to receive(:setup!)

			allow(FReCon).to receive(:require).with('pry')
			allow(FReCon).to receive(:pry)

			FReCon::Console.start
		end

		it 'calls FReCon.pry' do
			allow(FReCon).to receive(:pry)
			expect(FReCon).to receive(:pry)

			expect(FReCon::Console).to receive(:require).with('pry')

			FReCon::Console.start
		end
	end
end
