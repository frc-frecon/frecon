module FReCon
	class Controller
		def self.model_name
			# Removes the namespace "FReCon::" and "Controller" from
			# the class name, then singularizes the result.
			self.name.gsub(/FReCon::|Controller\Z/, "").singularize
		end
		
		def self.model
			# Removes the trailing "Controller" from the class name,
			# singularizes the result, and turns it into the class.
			self.name.gsub(/Controller\Z/, "").singularize.constantize
		end

		# The 404 error message.
		def self.could_not_find(value, attribute = "id")
			"Could not find #{model_name.downcase} of #{attribute} #{value}!"
		end
		
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
				# escape out of the function.
				return [400, ErrorFormatter.format(e.message)]
			end

			@model = model.new
			@model.attributes = post_data

			if @model.save
				[201, @model.to_json]
			else
				[422, ErrorFormatter.format(@model.errors.full_messages)]
			end
		end

		def self.update(request, params)
			return [400, "Must supply a #{model_name.downcase}!"] unless params[:id]

			request.body.rewind

			begin
				post_data = JSON.parse(request.body.read)
			rescue JSON::ParserError => e
				return [422, ErrorFormatter.format(e.message)]
			end

			@model = model.find params[:id]

			return [404, ErrorFormatter.format(could_not_find(params[:id]))] unless @model

			if @model.update_attributes(post_data)
				@model.to_json
			else
				[422, ErrorFormatter.format(@model.errors.full_messages)]
			end
		end

		def self.delete(params)
			@model = model.find params[:id]

			if @model
				if @model.destroy
					204
				else
					[422, ErrorFormatter.format(@model.errors.full_messages)]
				end
			else
				[404, ErrorFormatter.format(could_not_find(params[:id]))]
			end
		end

		def self.show(params)
			@model = model.find params[:id]

			if @model
				@model.to_json
			else
				[404, ErrorFormatter.format(could_not_find(params[:id]))]
			end
		end

		def self.index(params)
			params.delete("_")

			@models = params.empty? ? model.all : model.where(params)

			@models.to_json
		end
	end
end
