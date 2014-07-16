module FReCon
	class Team
		include Mongoid::Document
		include Mongoid::Timestamps

		field :number, type: Integer

		field :location, type: String
		field :name, type: String

		has_many :records

		def self.number(team_number)
			# Team.find_by number: team_number
			find_by number: team_number
		end

		def self.name_good?(name)
			false unless name.is_a?(String)
			true
		end

		def self.location_good?(location)
			false unless location.is_a?(String)
			true
		end

		def self.number_good?(number)
			false unless number.is_a?(Integer)
			true
		end

		def to_h
			{"name" => @name,
			 "location" => @location,
			 "number" => @number}
		end

		validates :number, :location, :name, presence: true
		validates :number, uniqueness: true

		# alias_method works by default solely on instance
		# methods, so change context to the metaclass of
		# Team and do aliasing there.
		class << self
			alias_method :with_number, :number
			alias_method :that_has_number, :number
		end

	end
end
