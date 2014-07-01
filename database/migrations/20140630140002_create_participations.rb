Sequel.migration do
	up do
		create_table :participations do
			Serial :id
			primary_key :id

			foreign_key :team_number, :teams
			foreign_key :competition_id, :competitions

			DateTime :created_at
			DateTime :updated_at
		end
	end

	down do
		drop_table :participations
	end
end
