module FReCon
	VERSION = "0.1.0"

	@environment_variable = :development

	def self.environment
		@environment_variable
	end

	def self.environment=(arg)
		puts arg
		@environment_variable = arg
	end
end
