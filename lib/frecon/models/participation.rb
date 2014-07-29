module FReCon
	class Participation
		include Mongoid::Document
		include Mongoid::Timestamps
		include Mongoid::Attributes::Dynamic

		belongs_to :competition
		belongs_to :team

		validates :competition_id, :team_id, presence: true
	end
end
