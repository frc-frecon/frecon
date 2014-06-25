require "logger"
require "sequel"

$db = Sequel.connect("sqlite://database/database.db", :logger => Logger.new("log/db.log"))

$db.create_table :teams do
	Integer :number
	String :name

	DateTime :created_at
	DateTime :updated_at

	primary_key :number
end

$db.create_table :matches do
	Integer :number

	String :classification
	Integer :red_score
	Integer :blue_score

	DateTime :created_at
	DateTime :updated_at

	primary_key :number
end

$db.create_table :records do
	Serial :id
	Text :notes

	String :position

	DateTime :created_at
	DateTime :updated_at

	primary_key :id
end
