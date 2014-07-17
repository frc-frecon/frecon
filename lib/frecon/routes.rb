require "frecon/controllers"

module FReCon
	module Routes
		def self.included(base)
			base.post "/teams/create" do
				FReCon::TeamsController.create request, params
			end

			base.put "/teams/:number" do
				FReCon::TeamsController.update request, params
			end

			base.delete "/teams/:number" do
				FReCon::TeamsController.delete params
			end

			base.get "/teams/:number" do
				FReCon::TeamsController.show params
			end

			base.get "/teams" do
				FReCon::TeamsController.index params
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

			base.post "/competitions/create" do
				FReCon::CompetitionsController.create request, params
			end

			base.put "/competitions/:id" do
				FReCon::CompetitionsController.update request, params
			end

			base.delete "/competitions/:id" do
				FReCon::CompetitionsController.delete params
			end

			base.get "/competitions" do
				FReCon::CompetitionsController.index params
			end

			base.get "/competitions/:id" do
				FReCon::CompetitionsController.show params
			end

			base.get "/competitions/:id/teams" do
				FReCon::CompetitionsController.teams params
			end

			base.get "/competitions/:id/matches" do
				FReCon::CompetitionsController.matches params
			end

			base.get "/competitions/:id/records" do
				FReCon::CompetitionsController.records params
			end

			base.post "/matches/create" do
				FReCon::MatchesController.create request, params
			end

			base.put "/matches/:id" do
				FReCon::MatchesController.update request, params
			end

			base.delete "/matches/:id" do
				FReCon::MatchesController.delete params
			end

			base.get "/matches/:id" do
				FReCon::MatchesController.show params
			end

			base.get "/matches" do
				FReCon::MatchesController.index params
			end

			base.get "/matches/:id/records" do
				FReCon::MatchesController.records params
			end

			base.get "/matches/:id/competition" do
				FReCon::MatchesController.competition params
			end

			base.post "/records/create" do
				FReCon::RecordsController.create request, params
			end

			base.put "/records/:id" do
				FReCon::RecordsController.update request, params
			end

			base.delete "/records/:id" do
				FReCon::RecordsController.delete params
			end

			base.get "/records/:id" do
				FReCon::RecordsController.show params
			end

			base.get "/records" do
				FReCon::RecordsController.index params
			end

			base.get "/records/:id/competition" do
				FReCon::RecordsController.competition params
			end

			base.get "/dump" do
				FReCon::DumpController.full params
			end
		end
	end
end
