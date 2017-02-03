get '/?' do
  erb :'session/login'
end

post "/login" do
  user = User.find_by(:username => params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect "/home"
  else
    redirect "/"
  end
end

get '/home' do
  erb :'home/index'
end

get '/logout' do
  erb :'session/logout'
end
