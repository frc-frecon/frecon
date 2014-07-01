namespace :db do
	desc "Run database migrations"
	task :migrate, [:version] do |t, args|
		require "sequel"
		Sequel.extension :migration

		if ENV["DATABASE_URL"]
			database = Sequel.connect(ENV.fetch("DATABASE_URL"))
		else
			database = Sequel.connect("sqlite://database/database.db")
		end

		if args[:version]
			puts "Migrating up/down to version #{args[:version]}"
			Sequel::Migrator.run(database, "database/migrations", target: args[:version].to_i)
		else
			puts "Migrating up to latest migration."
			Sequel::Migrator.run(database, "database/migrations")
		end
	end

	desc "Drop the database"
	task :drop do |t, args|
		Rake::Task["db:migrate"].invoke(0)
	end
end
