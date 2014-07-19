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
			resource_routes base, "teams", FReCon::TeamsController, [:create, :index]

			base.put "/teams/:number" do
				FReCon::TeamsController.update request, params
			end

			base.delete "/teams/:number" do
				FReCon::TeamsController.delete params
			end

			base.get "/teams/:number" do
				FReCon::TeamsController.show params
			end

			base.get "/teams/:number/records/?:competition_id?" do
				FReCon::TeamsController.records params
			end

			base.get "/teams/:number/matches/?:competition_id?" do
				FReCon::TeamsController.matches params
			end

			base.get "/teams/:number/competitions" do
				FReCon::TeamsController.competitions params
			end

			resource_routes base, "competitions", FReCon::CompetitionsController

			base.get "/competitions/:id/teams" do
				FReCon::CompetitionsController.teams params
			end

			base.get "/competitions/:id/matches" do
				FReCon::CompetitionsController.matches params
			end

			base.get "/competitions/:id/records" do
				FReCon::CompetitionsController.records params
			end

			resource_routes base, "matches", FReCon::MatchesController

			base.get "/matches/:id/records" do
				FReCon::MatchesController.records params
			end

			base.get "/matches/:id/competition" do
				FReCon::MatchesController.competition params
			end

			resource_routes base, "records", FReCon::RecordsController

			base.get "/records/:id/competition" do
				FReCon::RecordsController.competition params
			end

			base.get "/dump" do
				FReCon::DumpController.full params
			end
		end
	end
end
