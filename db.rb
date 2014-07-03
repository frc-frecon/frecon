require "logger"
require "mongo"
require "mongoid"

Mongoid.load!("mongoid.yml")

Mongoid.logger.level = Logger::DEBUG
Mongoid.logger = Logger.new("log/mongoid.log")

Moped.logger.level = Logger::DEBUG
Moped.logger = Logger.new("log/moped.log")

Dir.glob("models/*.rb").each do |file|
	require_relative file
end
