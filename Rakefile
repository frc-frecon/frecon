require "yard"

YARD::Config.load_plugin('tomdoc')
YARD::Config.load_plugin('mongoid')

namespace :docs do
	YARD::Rake::YardocTask.new do |task|
		task.files = ['lib/**/*.rb', 'bin/**/*']
	end
end
