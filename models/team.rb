class Team

	include Mongoid::Document
	include Mongoid::Timestamps

	field :number, type: Integer

	field :location, type: String
	field :name, type: String

	has_many :participations
	has_many :records

	validates :number, :location, :name, presence: true
	validates :number, uniqueness: true

end
