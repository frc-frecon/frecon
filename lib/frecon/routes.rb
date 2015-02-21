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
					begin
						controller.create request, params
					rescue RequestError => e
						e.return_value
					end
				end
			end

			if methods.include?(:update)
				base.put "/#{name}/:id" do
					begin
						controller.update request, params
					rescue RequestError => e
						e.return_value
					end
				end
			end

			if methods.include?(:delete)
				base.delete "/#{name}/:id" do
					begin
						controller.delete params
					rescue RequestError => e
						e.return_value
					end
				end
			end

			if methods.include?(:show)
				base.get "/#{name}/:id" do
					begin
						controller.show params
					rescue RequestError => e
						e.return_value
					end
				end
			end

			if methods.include?(:index)
				base.get "/#{name}" do
					begin
						controller.index params
					rescue RequestError => e
						e.return_value
					end
				end
			end
		end
		
		def self.included(base)
			resource_routes base, "teams", TeamsController, [:create, :index]

			base.put "/teams/:number" do
				begin
					TeamsController.update request, params
				rescue RequestError => e
					e.return_value
				end
			end

			base.delete "/teams/:number" do
				begin
					TeamsController.delete params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/teams/:number" do
				begin
					TeamsController.show params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/teams/:number/records/?:competition_id?" do
				begin
					TeamsController.records params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/teams/:number/matches/?:competition_id?" do
				begin
					TeamsController.matches params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/teams/:number/competitions" do
				begin
					TeamsController.competitions params
				rescue RequestError => e
					e.return_value
				end
			end

			resource_routes base, "competitions", CompetitionsController

			base.get "/competitions/:id/teams" do
				begin
					CompetitionsController.teams params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/competitions/:id/matches" do
				begin
					CompetitionsController.matches params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/competitions/:id/records" do
				begin
					CompetitionsController.records params
				rescue RequestError => e
					e.return_value
				end
			end

			resource_routes base, "matches", MatchesController

			base.get "/matches/:id/records" do
				begin
					MatchesController.records params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/matches/:id/competition" do
				begin
					MatchesController.competition params
				rescue RequestError => e
					e.return_value
				end
			end

			resource_routes base, "records", RecordsController

			base.get "/records/:id/competition" do
				begin
					RecordsController.competition params
				rescue RequestError => e
					e.return_value
				end
			end

			resource_routes base, "robots", RobotsController

			base.get "/robots/:id/competition" do
				begin
					RobotsController.competition params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/robots/:id/team" do
				begin
					RobotsController.team params
				rescue RequestError => e
					e.return_value
				end
			end

			resource_routes base, "participations", ParticipationsController

			base.get "/participations/:id/competition" do
				begin
					ParticipationsController.competition params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/participations/:id/team" do
				begin
					ParticipationsController.team params
				rescue RequestError => e
					e.return_value
				end
			end

			base.get "/dump" do
				begin
					DumpController.full params
				rescue RequestError => e
					e.return_value
				end
			end
		end
	end
end
