require "sequel"

class Match < Sequel::Model
	Integer :number

	String :classification
	Integer :red_score
	Integer :blue_score

	DateTime :created_at
	DateTime :updated_at

	self.set_primary_key(:number)
end
