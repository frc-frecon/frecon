Sequel.migration do
	up do
		create_table :teams do
			Integer :number
			primary_key :number

			String :name
			String :location

			DateTime :created_at
			DateTime :updated_at
		end
	end

	down do
		drop_table :teams
	end
end
