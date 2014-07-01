Sequel.migration do
	up do
		create_table :matches do
			Serial :id
			primary_key :id

			String :raw_number
			Integer :red_score
			Integer :blue_score

			foreign_key :competition_id, :competitions

			DateTime :created_at
			DateTime :updated_at
		end
	end

	down do
		drop_table :matches
	end
end
