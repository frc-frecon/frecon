class Team
	include Mongoid::Document
	include Mongoid::Timestamps

	field :number, type: Integer
	field :_id, type: Integer, default: ->{ number }

	field :name, type: String
	field :location, type: String

	has_many :participations
	has_many :records

	validates :_id, :number, uniqueness: true
end
