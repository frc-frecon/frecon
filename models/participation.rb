class Participation < Sequel::Model
	include Mongoid::Document
	include Mongoid::Timestamps

	belongs_to :competition
	belongs_to :team
end
