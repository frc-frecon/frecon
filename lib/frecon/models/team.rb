# lib/frecon/models/team.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/model"

module FReCon
	class Team < Model
		field :number, type: Integer

		field :location, type: String
		field :logo_path, type: String
		field :name, type: String
		
		has_many :participations, dependent: :destroy
		has_many :records, dependent: :destroy

		validates :number, presence: true, uniqueness: true, numericality: { greater_than: 0 }

		def self.number(team_number)
			# Team.find_by number: team_number
			find_by number: team_number
		end

		# alias_method works by default solely on instance
		# methods, so change context to the metaclass of
		# Team and do aliasing there.
		class << self
			alias_method :with_number, :number
			alias_method :that_has_number, :number
		end

	end
end
