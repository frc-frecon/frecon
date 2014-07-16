module FReCon
	module Routes
		def self.included(base)
			base.post "/team/create" do
				FReCon::TeamsController.create(request, params)
			end

			base.put "/team/update/:number" do
				FReCon::TeamsController.update(request, params)
			end


			base.get "/teams?.?:format" do
				FReCon::TeamsController.index params
			end

			base.get "/:mode?" do
				FReCon::ScoutController.show params
			end
		end
	end
end
