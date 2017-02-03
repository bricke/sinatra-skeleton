get '/?' do
  redirect '/home'
end

get '/home' do
	erb :'session/login'
end
