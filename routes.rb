get '/teams?.?:format' do
	TeamController.index params
end

get '/teams/:number?.?:format' do
	TeamController.show params
end

get '/:mode?' do
	ScoutController.show params
end
