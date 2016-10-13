# lib/frecon/database.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require 'logger'
require 'mongoid'
require 'tempfile'
require 'yaml'

require 'frecon/base/bson'
require 'frecon/mongoid/criteria'
require 'frecon/base/variables'
require 'frecon/models'

module FReCon
  # Public: A system to set up the database.
  class Database

    # Public: Set up the database.
    def self.setup!
      Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'), FReCon::ENVIRONMENT.variable)

      level = case (configured_level = FReCon::ENVIRONMENT.console['level'])
              when /^d/i
                ::Logger::DEBUG
              when /^e/i
                ::Logger::ERROR
              when /^f/i
                ::Logger::FATAL
              when /^i/i
                ::Logger::INFO
              when /^u/i
                ::Logger::UNKNOWN
              when /^w/i
                ::Logger::WARN
              else
                ::Logger::WARN
              end

      if !!configured_level
        Mongoid.logger = Logger.new($stdout)
        Mongoid.logger.level = level
      end
    end

  end
end
