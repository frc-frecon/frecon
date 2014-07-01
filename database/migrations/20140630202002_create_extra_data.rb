Sequel.migration do
	up do
		create_table :extra_data do
			Serial :id
			primary_key :id

			String :key
			Text :raw_value
			String :value_class

			Integer :parent_key
			String :parent_class

			DateTime :created_at
			DateTime :updated_at
		end
	end

	down do
		drop_table :extra_data
	end
end
