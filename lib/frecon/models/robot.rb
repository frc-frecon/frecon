require "frecon/model"

module FReCon
	class Robot < Model
		# Pre-scouting changes depending on the team doing it,
		# so we are leaving the defined fields blank.
		# Store your own information using dynamic attributes.

		belongs_to :competition
		belongs_to :team
	end
end
