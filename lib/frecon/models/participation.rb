require "frecon/model"

module FReCon
	class Participation < Model
		belongs_to :competition
		belongs_to :team

		validates :competition_id, :team_id, presence: true
		validates :team_id, uniqueness: { scope: :competition_id }
	end
end
