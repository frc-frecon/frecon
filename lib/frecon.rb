# lib/frecon.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "mongoid"

require "frecon/base"

require "frecon/controller"
require "frecon/controllers"
require "frecon/model"
require "frecon/models"
require "frecon/scraper"
require "frecon/scrapers"

require "frecon/configuration"
require "frecon/configuration_file"
require "frecon/match_number"
require "frecon/position"
require "frecon/request_error"
require "frecon/routes"

require "frecon/database"
require "frecon/server"
require "frecon/console"
