require "logger"
require "mongoid"

require "frecon/models"

module FReCon
	class Database
		def self.setup
			Mongoid.load!(File.join(File.dirname(__FILE__), "mongoid.yml"), ENVIRONMENT)
			
			Mongoid.logger.level = Logger::DEBUG
			Mongoid.logger = Logger.new($stdout)

			Moped.logger.level = Logger::DEBUG
			Moped.logger = Logger.new($stdout)
		end
	end
end
