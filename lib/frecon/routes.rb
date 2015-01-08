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
		# verb should be a Symbol.
		def self.safe_route(base, verb, url)
			base.send(verb, url) do
				begin
					yield
				rescue RequestError => e
					[e.code, e.message]
				end
			end
		end
		
		def self.resource_routes(base, name, controller, methods = [:create, :update, :delete, :show, :index])
			if methods.include?(:create)
				safe_route(base, :post, "/#{name}") do
					controller.create request, params
				end
			end

			if methods.include?(:update)
				safe_route(base, :put, "/#{name}/:id") do
					controller.update request, params
				end
			end

			if methods.include?(:delete)
				safe_route(base, :delete, "/#{name}/:id") do
					controller.delete params
				end
			end

			if methods.include?(:show)
				safe_route(base, :get, "/#{name}/:id") do
					controller.show params
				end
			end

			if methods.include?(:index)
				safe_route(base, :get, "/#{name}") do
					controller.index params
				end
			end
		end
		
		def self.included(base)
			resource_routes base, "teams", TeamsController, [:create, :index]

			safe_route(base, :put, "/teams/:number") do
				TeamsController.update request, params
			end

			safe_route(base, :delete, "/teams/:number") do
				TeamsController.delete params
			end

			safe_route(base, :get, "/teams/:number") do
				TeamsController.show params
			end

			safe_route(base, :get, "/teams/:number/records/?:competition_id?") do
				TeamsController.records params
			end

			safe_route(base, :get, "/teams/:number/matches/?:competition_id?") do
				TeamsController.matches params
			end

			safe_route(base, :get, "/teams/:number/competitions") do
				TeamsController.competitions params
			end

			resource_routes base, "competitions", CompetitionsController

			safe_route(base, :get, "/competitions/:id/teams") do
				CompetitionsController.teams params
			end

			safe_route(base, :get, "/competitions/:id/matches") do
				CompetitionsController.matches params
			end

			safe_route(base, :get, "/competitions/:id/records") do
				CompetitionsController.records params
			end

			resource_routes base, "matches", MatchesController

			safe_route(base, :get, "/matches/:id/records") do
				MatchesController.records params
			end

			safe_route(base, :get, "/matches/:id/competition") do
				MatchesController.competition params
			end

			resource_routes base, "records", RecordsController

			safe_route(base, :get, "/records/:id/competition") do
				RecordsController.competition params
			end

			resource_routes base, "robots", RobotsController

			safe_route(base, :get, "/robots/:id/competition") do
				RobotsController.competition params
			end

			safe_route(base, :get, "/robots/:id/team") do
				RobotsController.team params
			end

			resource_routes base, "participations", ParticipationsController

			safe_route(base, :get, "/participations/:id/competition") do
				ParticipationsController.competition params
			end

			safe_route(base, :get, "/participations/:id/team") do
				ParticipationsController.team params
			end

			safe_route(base, :get, "/dump") do
				DumpController.full params
			end
		end
	end
end
