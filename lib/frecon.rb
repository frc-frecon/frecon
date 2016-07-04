# lib/frecon.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require 'frecon/base/bson'
require 'frecon/base/environment'
require 'frecon/base/object'
require 'frecon/base/variables'
require 'frecon/base'

require 'frecon/console'

require 'frecon/controller'
require 'frecon/controllers/competitions_controller'
require 'frecon/controllers/dump_controller'
require 'frecon/controllers/matches_controller'
require 'frecon/controllers/participations_controller'
require 'frecon/controllers/records_controller'
require 'frecon/controllers/robots_controller'
require 'frecon/controllers/teams_controller'
require 'frecon/controllers'

require 'frecon/database'
require 'frecon/match_number'

require 'frecon/model'
require 'frecon/models/competition'
require 'frecon/models/match'
require 'frecon/models/participation'
require 'frecon/models/record'
require 'frecon/models/robot'
require 'frecon/models/team'
require 'frecon/models'

require 'frecon/scraper'
require 'frecon/scrapers'

require 'frecon/mongoid/criteria'
require 'frecon/position'
require 'frecon/request_error'
require 'frecon/routes'

require 'frecon/scraper'
require 'frecon/scrapers'

require 'frecon/server'
