require "yaml"

module FReCon
	class Environment

		attr_accessor :server
		attr_accessor :console
		attr_accessor :database

		def variable
			@variable
		end

		def variable=(symbol)
			@variable = symbol if validate_symbol(symbol)
		end

		def initialize(symbol, server: {}, console: {}, database: {})
			@variable = symbol if validate_symbol(symbol)

			read_configurations

			@server = @server.merge(server)
			@console = @console.merge(console)
			@database = @database.merge(database)

			@server = @server.merge(server_defaults)
			@console = @console.merge(console_defaults)
			@database = @database.merge(database_defaults)
		end

		def read_configurations
			default = default_configuration
			system = system_configuration
			user = user_configuration

			configuration = default || {}
			configuration.merge(system || {})
			configuration.merge(user || {})

			@server = configuration["server"] || {}
			@console = configuration["console"] || {}
			@database = configuration["database"] || {}
		end

		def read_configuration(filename)
			YAML.load_file(filename) if filename
		end

		def default_configuration
			read_configuration(default_configuration_filename)
		end

		def system_configuration
			read_configuration(system_configuration_filename)
		end

		def user_configuration
			read_configuration(user_configuration_filename)
		end

		protected

		def default_configuration_filename
			File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "config", "default.yml"))
		end

		def system_configuration_filename
			directories = (ENV['XDG_CONFIG_DIRS'] || '').split(':') ||
				[File.join('', 'usr', 'share'),
				 File.join('', 'usr', 'local', 'share')]

			file = nil

			directories.each do |directory|
				check_file = File.join(directory, 'frecon', 'config.yml')
				file = check_file if File.exist?(check_file)
			end

			file
		end

		def user_configuration_filename
			configuration_home = ENV['XDG_CONFIG_HOME'] || File.join(Dir.home, '.config')

			if File.exist?(file = File.join(configuration_home, 'frecon.yml'))
				file
			end
		end

		def validate_symbol(symbol)
			raise ArgumentError, "Environment variable is not one of #{self.valid_environments}" unless
				valid_environments.include?(symbol)

			true
		end

		def valid_environments
			[:development, :production, :test]
		end

		def server_defaults
			{"host" => "localhost", "port" => 4567}
		end

		def console_defaults
			{}
		end

		def database_defaults
			{}
		end

	end
end
