require "frecon/model"

module FReCon
	class Robot < Model
		field :name, type: String

		belongs_to :competition
		belongs_to :team
	end
end
