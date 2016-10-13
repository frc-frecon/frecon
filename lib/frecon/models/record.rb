# lib/frecon/models/record.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require 'frecon/model'
require 'frecon/position'

module FReCon
  # Public: The Record model.
  class Record < Model

    field :notes, type: String
    field :position, type: Position

    belongs_to :match
    belongs_to :participation

    validates :position, :match_id, :participation_id, presence: true

    # Public: Get this Record's Match's Competition
    def competition
      match.competition
    end

    # Public: Get this Record's Participation's Robot
    def robot
      participation.robot
    end

    # Public: Get this Record's Participation's Robot's Team
    def team
      participation.robot.team
    end

    register_routable_relation :match, 'match'
    register_routable_relation :competition, 'competition'
    register_routable_relation :participation, 'participation'
    register_routable_relation :robot, 'robot'
    register_routable_relation :team, 'team'

  end
end
