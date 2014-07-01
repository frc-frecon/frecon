Sequel.migration do
	up do
		create_table :competitions do
			Serial :id
			primary_key :id

			String :name
			String :location

			DateTime :created_at
			DateTime :updated_at
		end
	end

	down do
		drop_table :competitions
	end
end
