require 'yard'

YARD::Config.load_plugin('tomdoc')
YARD::Config.load_plugin('mongoid')

namespace :docs do
	YARD::Rake::YardocTask.new :generate do |task|
		task.files = ['lib/**/*.rb', 'bin/**/*']
	end

	YARD::Rake::YardocTask.new :list_undoc do |task|
		task.files = ['lib/**/*.rb', 'bin/**/*']
		task.stats_options = ['--list-undoc']
	end
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec
