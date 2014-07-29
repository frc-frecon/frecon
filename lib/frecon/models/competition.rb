module FReCon
	class Competition
		include Mongoid::Document
		include Mongoid::Timestamps
		include Mongoid::Attributes::Dynamic
		
		field :location, type: String
		field :name, type: String

		has_many :matches, dependent: :destroy
		has_many :participations, dependent: :destroy
		has_many :teams, through: :participations
		
		validates :location, :name, presence: true
		validates :name, uniqueness: true

		def records
			matches = self.matches
			
			Record.in match_id: matches.map { |match| match.id }
		end
	end
end
