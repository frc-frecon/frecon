require "json"
require "frecon/models"

module FReCon
	class MatchesController
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

			@match = FReCon::Match.new
			@match.attributes = post_data

			if @match.save
				# Use to_json for now; we can filter it later.
				[201, @match.to_json]
			else
				[422, FReCon::ErrorFormatter.format(@match.errors.full_messages)]
			end
		end

		def self.update(request, params)
			return [400, "Must supply a match id!"] unless params[:id]

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

			@match = FReCon::Match.find params[:id]

			if @match.nil?
				return [404, FReCon::ErrorFormatter.format("Could not find match of id #{params[:id]}!")]
			end

			if @match.update_attributes(post_data)
				@match.to_json
			else
				[422, FReCon::ErrorFormatter.format(@match.errors.full_messages)]
			end
		end

		def self.delete(params)
			@match = Match.find params[:id]

			if @match
				if @match.destroy
					204
				else
					[422, FReCon::ErrorFormatter.format(@match.errors.full_messages)]
				end
			else
				[404, FReCon::ErrorFormatter.format("Could not find match of id #{params[:id]}!")]
			end
		end

		def self.show(params)
			@match = Match.find params[:id]

			if @match
				@match.to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find match of id #{params[:id]}!")]
			end
		end

		def self.index(params)
			@matches = Match.all

			@matches.to_json
		end

		def self.competition(params)
			@match = Match.find params[:id]

			if @match
				@match.competition.to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find match of id #{params[:id]}!")]
			end
		end

		def self.records(params)
			@match = Match.find params[:id]

			if @match
				@match.records.to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find match of id #{params[:id]}!")]
			end
		end
	end
end
