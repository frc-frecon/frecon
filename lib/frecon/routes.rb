module FReCon
	module Routes
		def self.included(base)
			base.get "/teams?.?:format" do
				FReCon::TeamsController.index params
			end

			base.get "/teams/:number?.?:format" do
				FReCon::TeamsController.show params
			end

			base.get "/:mode?" do
				FReCon::ScoutController.show params
			end
		end
	end
end
