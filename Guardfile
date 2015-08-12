require "frecon"

guard :rspec, cmd: "bundle exec rspec" do
	# Watch all of the spec files, and, when one is modified,
	# simply run it.
	watch(%r{^spec/.+_spec\.rb$})

	# Watch all of the source files in lib/ and bin/, and run the
	# corresponding spec while maintaining directory structure.
	watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
	watch(%r{^bin/(.+)$})         { |m| "spec/bin/#{m[1]}_spec.rb" }

	# When spec_helper is modified, run everything.
	watch("spec/spec_helper.rb")  { "spec" }
end
