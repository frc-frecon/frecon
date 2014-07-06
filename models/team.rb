class Team
	include Mongoid::Document
	include Mongoid::Timestamps

	field :number, type: Integer
	field :name, type: String
	field :location, type: String

	has_many :participations
	has_many :records

	validates :_id, :number, uniqueness: true
end
