# lib/frecon/routes.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

require "frecon/controllers"

module FReCon
	# Public: A module containing all of the routes.
	module Routes
		# Public: Set up basic resource route handlers.
		#
		# base       - Sinatra::Application to register the routes under.
		# name       - String containing the model name.
		# controller - Controller-like object that contains key methods.
		def self.resource_routes(base, name, controller)
			base.post "/#{name}" do
				begin
					controller.create request, params
				rescue RequestError => e
					e.return_value
				end
			end

			base.put "/#{name}/:id" do
				begin
					controller.update request, params
				rescue RequestError => e
					e.return_value
				end
			end

			base.delete "/#{name}/:id" do
				begin
					controller.delete params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/#{name}/:id" do
				begin
					controller.show params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/#{name}" do
				begin
					controller.index params
				rescue RequestError => e
					e.return_value
				end
			end
		end

		def self.attribute_routes(base, name, controller)
			model = controller.model

			model_attribute_methods = model.class_variable_get(:@@attributes)

			model_attribute_methods.each do |model_attribute_method|
				base.get "/#{name}/:id/#{model_attribute_method[:attribute]}" do
					begin
						@model = controller.find_model(params)

						params.delete("id")

						result = @model.method(model_attribute_method[:method]).call

						if result.is_a? Mongoid::Criteria
							params.delete("splat")
							params.delete("captures")

							result.psv_filter(params).to_json
						else
							result.to_json
						end
					rescue RequestError => e
						e.return_value
					end
				end
			end
		end

		def self.included(base)
			resource_routes base, "teams", TeamsController
			resource_routes base, "competitions", CompetitionsController
			resource_routes base, "matches", MatchesController
			resource_routes base, "records", RecordsController
			resource_routes base, "robots", RobotsController
			resource_routes base, "participations", ParticipationsController

			attribute_routes base, "teams", TeamsController
			attribute_routes base, "competitions", CompetitionsController
			attribute_routes base, "matches", MatchesController
			attribute_routes base, "records", RecordsController
			attribute_routes base, "robots", RobotsController
			attribute_routes base, "participations", ParticipationsController

			base.before do
				params.delete("_")
			end

			base.get "/dump" do
				begin
					DumpController.full params
				rescue RequestError => e
					e.return_value
				end
			end

			if ENV["PRINT_ROUTES"]
				base.routes.each do |verb, routes|
					puts "#{verb}:"

					routes.each do |route|
						puts "  #{route[0]}"
					end
				end
			end
		end
	end
end
