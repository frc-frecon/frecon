namespace :db do
	desc "Run database migrations"
	task :migrate, [:version] do |t, args|
		require "sequel"
		Sequel.extension :migration
		database = Sequel.connect(ENV.fetch("DATABASE_URL"))
		if args[:version]
			puts "Migrating to version #{args[:version]}"
			Sequel::Migrator.run(database, "database/migrations", target: args[:version].to_i)
		else
			puts "Migrating up to latest migration."
			Sequel::Migrator.run(database, "database/migrations")
		end
	end

	task :drop do |t, args|
		Rake::Task["db:migrate"].invoke(0)
	end
end
