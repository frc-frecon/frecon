# Should be moved probably.
class Position
	
end

class Record
	include Mongoid::Document
	include Mongoid::Timestamps

	field :notes, type: Text
	field :position, type: Position

	belongs_to :team
	belongs_to :match
end
