require "json"
require "frecon/models"

module FReCon
	class RecordsController
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

			@record = FReCon::Record.new
			@record.attributes = post_data

			if @record.save
				# Use to_json for now; we can filter it later.
				[201, @record.to_json]
			else
				[422, FReCon::ErrorFormatter.format(@record.errors.full_messages)]
			end
		end

		def self.update(request, params)
			return [400, "Must supply a record id!"] unless params[:id]

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

			@record = FReCon::Record.find params[:id]

			if @record.nil?
				return [404, FReCon::ErrorFormatter.format("Could not find record of id #{params[:id]}!")]
			end

			if @record.update_attributes(post_data)
				@record.to_json
			else
				[422, FReCon::ErrorFormatter.format(@record.errors.full_messages)]
			end
		end

		def self.delete(params)
			@record = Record.find params[:id]

			if @record
				if @record.destroy
					204
				else
					[422, FReCon::ErrorFormatter.format(@record.errors.full_messages)]
				end
			else
				[404, FReCon::ErrorFormatter.format("Could not find record of id #{params[:id]}!")]
			end
		end

		def self.show(params)
			@record = Record.find params[:id]

			if @record
				@record.to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find record of id #{params[:id]}!")]
			end
		end

		def self.index(params)
			@records = params.empty? ? Record.all : Record.where(params)

			@records.to_json
		end

		def self.competition(params)
			@record = Record.find params[:id]

			if @record
				@record.competition.to_json
			else
				[404, FReCon::ErrorFormatter.format("Could not find record of id #{params[:id]}!")]
			end
		end
	end
end
