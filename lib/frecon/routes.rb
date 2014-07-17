module FReCon
	module Routes
		def self.included(base)
			base.post "/teams/create" do
				FReCon::TeamsController.create(request, params)
			end

			base.put "/teams/:number" do
				FReCon::TeamsController.update(request, params)
			end

			base.get "/team/:number" do
				FReCon::TeamsController.show params
			end

			base.get "/teams?.?:format" do
				FReCon::TeamsController.index params
			end
		end
	end
end
