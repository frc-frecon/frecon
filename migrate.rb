require "logger"
require "sequel"

$db = Sequel.connect("sqlite://database/database.db", :logger => Logger.new("log/db.log"))
