class Team

	include Mongoid::Document
	include Mongoid::Timestamps

	field :number, type: Integer

	field :location, type: String
	field :name, type: String

	has_many :participations
	has_many :records

	def self.with_number(number)
		raise ArgumentError, "Must supply a team number!" unless number.is_a?(Integer)

		return self.where(number: number).first
	end

	validates :number, :location, :name, presence: true
	validates :number, uniqueness: true

end

# alias_method works by default solely on instance
# methods, so change context to the metaclass of
# Team and do those operations there.
class << Team

	# This just allows Team queries to make a
	# bit more sense. You can always just use
	# with_number, but that_has_number rolls off
	# the tongue a bit better.
	alias_method :that_has_number, :with_number

end
