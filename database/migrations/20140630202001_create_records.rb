Sequel.migration do
	up do
		create_table :records do
			Serial :id
			primary_key :id

			Text :notes
			String :raw_position

			foreign_key :match_id, :matches
			foreign_key :team_number, :teams

			DateTime :created_at
			DateTime :updated_at
		end
	end

	down do
		drop_table :records
	end
end
