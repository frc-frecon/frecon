require "json"

require "frecon/error_formatter.rb"

module FReCon
	class CompetitionsController
		def self.create(request, params)
			# Rewind the request body (an IO object)
			# in case someone else has already played
			# through it.
			request.body.rewind

			begin
				# Parse the POST data as a JSON hash
				# (because that's what it is)
				post_data = JSON.parse(request.body.read)
			rescue JSON::ParserError => e
				# If we have malformed JSON (JSON::ParserError is raised),
				# escape out of the function
				return [400, FReCon::ErrorFormatter.format(e.message)]
			end
			
			@competition = FReCon::Competition.new
			@competition.attributes = post_data

			if @competition.save
				# Use to_json for now; we can filter it later.
				[201, @competition.to_json]
			else
				[422, FReCon::ErrorFormatter.format(@competition.errors.full_messages)]
			end
		end

		def self.update(request, params)
			return [400, "Must supply a competition id!"] unless params[:id]

			# Rewind the request body (an IO object)
			# in case someone else has already played
			# through it.
			request.body.rewind

			begin
				# Parse the POST data as a JSON hash
				# (because that's what it is)
				post_data = JSON.parse(request.body.read)
			rescue JSON::ParserError => e
				# If we have malformed JSON (JSON::ParserError is raised),
				# escape out of the function
				return [422, FReCon::ErrorFormatter.format(e.message)]
			end

			@competition = FReCon::Competition.find params[:id]

			if @competition.nil?
				return [404, FReCon::ErrorFormatter.format("Could not find competition of id #{params[:id]}!")]
			end

			if @competition.update_attributes(post_data)
				@competition.to_json
			else
				[422, FReCon::ErrorFormatter.format(@competition.errors.full_messages)]
			end
		end

		def self.delete(params)
			@competition = Competition.find params[:id]

			if @competition
				if @competition.destroy
					204
				else
					[422, FReCon::ErrorFormatter.format(@competition.errors.full_messages)]
				end
			else
				[404, FReCon::ErrorFormatter.format("Could not find competition of id #{params[:id]}!")]
			end
		end

		def self.show(params)
			@competition = Competition.find params[:id]

			if @competition
				@competition.to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find competition of id #{params[:id]}!")]
			end
		end

		def self.index(params)
			@competitions = Competition.all

			@competitions.to_json
		end
	end
end
