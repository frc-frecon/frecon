require_relative "server"

begin
	require "pry"

	Pry.start
rescue Exception => e
	require "irb"

	IRB.start
end
