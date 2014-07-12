module FReCon
	module Routes
		get "/teams?.?:format" do
			TeamsController.index params
		end

		get "/teams/:number?.?:format" do
			TeamsController.show params
		end

		get "/:mode?" do
			ScoutController.show params
		end
	end
end
