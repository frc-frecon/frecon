require "logger"
require "mongoid"

module FReCon
	class Database
		def self.setup(environment = :development)
			Mongoid.load!(File.join(File.dirname(__FILE__), "mongoid.yml"), environment)

			Mongoid.logger.level = Logger::DEBUG
			Mongoid.logger = Logger.new($stdout)

			Moped.logger.level = Logger::DEBUG
			Moped.logger = Logger.new($stdout)

			Dir.glob(File.join(File.dirname(__FILE__), "models/*.rb")).each do |file|
				require_relative file
			end
		end
	end
end
