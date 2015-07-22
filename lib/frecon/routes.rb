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
	module Routes
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

		def self.included(base)
			resource_routes base, "teams", TeamsController
			resource_routes base, "competitions", CompetitionsController
			resource_routes base, "matches", MatchesController
			resource_routes base, "records", RecordsController
			resource_routes base, "robots", RobotsController
			resource_routes base, "participations", ParticipationsController

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

			base.routes.each do |verb, routes|
				puts "#{verb}:"

				routes.each do |route|
					puts "  #{route[0]}"
				end
			end
		end
	end
end
