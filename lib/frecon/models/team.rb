# lib/frecon/models/team.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require 'frecon/model'

module FReCon
	# Public: The Team model.
	class Team < Model

		field :number, type: Integer

		field :location, type: String
		field :logo_path, type: String
		field :name, type: String

		has_many :robots, dependent: :destroy

		validates :number, presence: true, uniqueness: true, numericality: { greater_than: 0 }

		# Public: Find a team by number.
		#
		# team_number - An Integer to be used to compare.
		#
		# Returns a Team if one exists with the given number, otherwise nil.
		def self.number(team_number)
			find_by number: team_number
		end

		# Public: Get this Team's Robots' Participations
		def participations
			Participation.in robot_id: robots.map(&:id)
		end

		# Public: Get this Team's Robots' Participations' Competitions
		def competitions
			Competition.in id: participations.map(&:competition_id)
		end

		# Public: Get this Team's Robots' Participations' Records
		def records
			Record.in participation_id: participations.map(&:id)
		end

		# Public: Get this Team's Robots' Participations' Competitions' Matches
		def matches
			Match.in competition_id: competitions.map(&:id)
		end

		register_routable_relation :robots, 'robots'
		register_routable_relation :participations, 'participations'
		register_routable_relation :competitions, 'competitions'
		register_routable_relation :records, 'records'
		register_routable_relation :matches, 'matches'

		# alias_method works by default solely on instance
		# methods, so change context to the metaclass of
		# Team and do aliasing there.
		class << self
			alias_method :with_number, :number
			alias_method :that_has_number, :number
		end

	end
end
