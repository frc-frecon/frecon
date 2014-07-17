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

			base.post "/competitions/create" do
				FReCon::CompetitionsController.create request, params
			end

			base.put "/competitions/:id" do
				FReCon::CompetitionsController.update request, params
			end

			base.delete "/competitions/:id" do
				FReCon::CompetitionsController.delete params
			end

			base.get "/competitions/:id" do
				FReCon::CompetitionsController.show params
			end

			base.get "/competitions" do
				FReCon::CompetitionsController.index params
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
		end
	end
end
