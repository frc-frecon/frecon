module FReCon
	class Team
		include Mongoid::Document
		include Mongoid::Timestamps

		field :number, type: Integer

		field :location, type: String
		field :name, type: String

		has_many :records

		validates :number, presence: true, uniqueness: true, numericality: { greater_than: 0 }

		def self.number(team_number)
			# Team.find_by number: team_number
			find_by number: team_number
		end

		def self.name_good?(name)
			false unless name
			false unless name.is_a?(String)
			true
		end

		def self.location_good?(location)
			false unless location
			false unless location.is_a?(String)
			true
		end

		def self.number_good?(number)
			false unless number
			false unless number.is_a?(Integer)
			true
		end

		def name_good?
			FReCon::Team.name_good?(@name)
		end

		def number_good?
			FReCon::Team.number_good?(@number)
		end

		def location_good?
			FReCon::Team.location_good?(@location)
		end

		def to_h
			{"name" => @name, "location" => @location, "number" => @number}
		end

		# alias_method works by default solely on instance
		# methods, so change context to the metaclass of
		# Team and do aliasing there.
		class << self
			alias_method :with_number, :number
			alias_method :that_has_number, :number
		end

	end
end
