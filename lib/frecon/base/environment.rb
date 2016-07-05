require 'yaml'

module FReCon
	# Public: A class to represent the operational constraints for the FReCon
	# instance.
	class Environment

		# Public: The configuration Hash for the server-related configuration.
		#
		# Keys will typically include 'port', 'host', etc.
		attr_accessor :server

		# Public: The configuration Hash for the console-related configuration.
		attr_accessor :console

		# Public: The configuration Hash for the database-related configuration.
		#
		# Keys will typically include 'mongoid', which should be a Hash
		# representation of a valid mongoid.yml file.
		attr_accessor :database

		# Public: Get the configuration variable.
		#
		# Returns the value of @variable.
		attr_reader :variable

		# Public: Validate, then set the configuration variable.
		def variable=(symbol)
			@variable = symbol if validate_symbol(symbol)
		end

		# Public: Initialize an Environment.
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

		# Public: Read the various configurations on a system.
		#
		# Reads, then merges, the configurations present on a system.  Then, splices
		# out the server, console, and database configurations and assigns them.
		#
		# If a configuration cannot be found, a value of {} is used for the merging,
		# and it is considered to be simply noneffectual.  Defaults should always be
		# specified in the default configuration file.
		#
		# Returns the merged configuration.
		def read_configurations
			# Read the configurations
			default = default_configuration
			system = system_configuration
			user = user_configuration

			# Create a configuration, initialize it to the default configuration.
			#
			# Then, merge with the system configuration, then the user configuration.
			configuration = default || {}
			configuration.merge(system || {})
			configuration.merge(user || {})

			# Grab out the 'server', 'console', and 'database' values from the
			# configuration and store those in the appropriate instance variables.
			@server = configuration['server'] || {}
			@console = configuration['console'] || {}
			@database = configuration['database'] || {}

			configuration
		end

		# Public: Read a configuration from a given filename.
		#
		# Uses YAML to parse the given filename.
		#
		# filename - String containing the path to a file.
		#
		# Returns a Hash containing the parsed data from the given file.
		def read_configuration(filename)
			YAML.load_file(filename) if (filename &&
			                             File.exist?(filename) &&
			                             File.readable?(filename))
		end


		# Public: Read and parse the defaults configuration file.
		def default_configuration
			read_configuration(default_configuration_filename)
		end

		# Public: Read and parse the system configuration file.
		def system_configuration
			read_configuration(system_configuration_filename)
		end

		# Public: Read and parse the user configuration file.
		def user_configuration
			read_configuration(user_configuration_filename)
		end

		protected

		# Public: Generate the filename for the defaults configuration file.
		def default_configuration_filename
			File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'config', 'default.yml'))
		end

		# Public: Generate the filename for the system configuration file.
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

		# Public: Generate the filename for the user configuration file.
		def user_configuration_filename
			configuration_home = ENV['XDG_CONFIG_HOME'] || File.join(Dir.home, '.config')

			if File.exist?(file = File.join(configuration_home, 'frecon.yml'))
				file
			end
		end

		# Public: Validate a value for @variable.
		#
		# Checks the value for @variable against a list of valid environments.
		def validate_symbol(symbol)
			raise ArgumentError, "Environment variable is not one of #{self.valid_environments}" unless
				valid_environments.include?(symbol)

			true
		end

		# Public: Produce a list of valid environments.
		def valid_environments
			[:development, :production, :test]
		end

		# Public: Return a Hash representing the default server settings.
		def server_defaults
			{'host' => 'localhost', 'port' => 4567}
		end

		# Public: Return a Hash representing the default console settings.
		def console_defaults
			{}
		end

		# Public: Return a Hash representing the default database settings.
		def database_defaults
			{}
		end

	end
end
