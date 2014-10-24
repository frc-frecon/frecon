module FReCon
	VERSION = "0.1.1"

	@environment_variable = :development

	def self.environment
		@environment_variable
	end

	def self.environment=(arg)
		@environment_variable = arg
	end
end
