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
		def self.resource_routes(base, name, controller, methods = [:create, :update, :delete, :show, :index])
			if methods.include?(:create)
				base.post "/#{name}" do
					controller.create request, params
				end
			end

			if methods.include?(:update)
				base.put "/#{name}/:id" do
					controller.update request, params
				end
			end

			if methods.include?(:delete)
				base.delete "/#{name}/:id" do
					controller.delete params
				end
			end

			if methods.include?(:show)
				base.get "/#{name}/:id" do
					controller.show params
				end
			end

			if methods.include?(:index)
				base.get "/#{name}" do
					controller.index params
				end
			end
		end
		
		def self.included(base)
			resource_routes base, "teams", TeamsController, [:create, :index]

			base.put "/teams/:number" do
				TeamsController.update request, params
			end

			base.delete "/teams/:number" do
				TeamsController.delete params
			end

			base.get "/teams/:number" do
				TeamsController.show params
			end

			base.get "/teams/:number/records/?:competition_id?" do
				TeamsController.records params
			end

			base.get "/teams/:number/matches/?:competition_id?" do
				TeamsController.matches params
			end

			base.get "/teams/:number/competitions" do
				TeamsController.competitions params
			end

			resource_routes base, "competitions", CompetitionsController

			base.get "/competitions/:id/teams" do
				CompetitionsController.teams params
			end

			base.get "/competitions/:id/matches" do
				CompetitionsController.matches params
			end

			base.get "/competitions/:id/records" do
				CompetitionsController.records params
			end

			resource_routes base, "matches", MatchesController

			base.get "/matches/:id/records" do
				MatchesController.records params
			end

			base.get "/matches/:id/competition" do
				MatchesController.competition params
			end

			resource_routes base, "records", RecordsController

			base.get "/records/:id/competition" do
				RecordsController.competition params
			end

			resource_routes base, "robots", RobotsController

			base.get "/robots/:id/competition" do
				RobotsController.competition params
			end

			base.get "/robots/:id/team" do
				RobotsController.team params
			end

			resource_routes base, "participations", ParticipationsController

			base.get "/participations/:id/competition" do
				ParticipationsController.competition params
			end

			base.get "/participations/:id/team" do
				ParticipationsController.team params
			end

			base.get "/dump" do
				DumpController.full params
			end
		end
	end
end
