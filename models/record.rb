# Should be moved probably.
class Position
	# MongoDB compatibility methods.
	def self.demongoize(object)
	end

	def self.mongoize(object)
	end

	def self.evolve(object)
	end

	# Custom methods.
	attr_reader :alliance, :number

	def initialize(string)
		@alliance = (string[0] == "r" ? :red : :blue)
		@number = string[1].to_i
	end
	
	def is_red?
		@alliance == :red
	end

	def is_blue?
		@alliance == :blue
	end

	alias_method :was_red?, :is_red?
	alias_method :was_blue?, :is_blue?
end

class Record
	include Mongoid::Document
	include Mongoid::Timestamps

	field :notes, type: String
	field :position, type: Position

	belongs_to :team
	belongs_to :match
end
