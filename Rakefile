require "rdoc/task"

namespace :docs do
	RDoc::Task.new rdoc: :generate, clobber_rdoc: :clean, rerdoc: :regenerate do |rdoc|
		rdoc.main = "README.md"
		rdoc.rdoc_dir = "doc"
		rdoc.rdoc_files.include("README.md", "lib/", "bin/")
	end
end
