module FReCon
	class Competition
		include Mongoid::Document
		include Mongoid::Timestamps

		field :location, type: String
		field :name, type: String

		has_many :matches
		has_many :participations

		validates :location, :name, presence: true
	end
end
