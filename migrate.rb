require "logger"
require "sequel"

$db = Sequel.connect("sqlite://database/database.db", :logger => Logger.new("log/db.log"))

$db.create_table :teams do
	Integer :number
	primary_key :number

	String :name
	String :location

	DateTime :created_at
	DateTime :updated_at
end

$db.create_table :participations do
	Serial :id
	primary_key :id

	foreign_key :competition_id, :competitions
	foreign_key :team_number, :teams

	DateTime :created_at
	DateTime :updated_at
end

$db.create_table :matches do
	Serial :id
	primary_key :id

	String :raw_number
	Integer :red_score
	Integer :blue_score

	foreign_key :competition_id, :competitions

	DateTime :created_at
	DateTime :updated_at
end

$db.create_table :competitions do
	Serial :id
	primary_key :id

	String :name
	String :location

	DateTime :created_at
	DateTime :updated_at
end

$db.create_table :records do
	Serial :id
	primary_key :id

	Text :notes
	String :raw_position

	foreign_key :match_id, :matches
	foreign_key :team_number, :teams

	DateTime :created_at
	DateTime :updated_at
end

$db.create_table :extra_data do
	Serial :id
	primary_key :id

	String :key
	Text :raw_value
	String :value_class

	Integer :parent_key
	String :parent_class

	DateTime :created_at
	DateTime :updated_at
end
