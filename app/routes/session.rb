get '/?' do
  erb :'session/login', :layout => false
end

post "/login" do
  user = User.find_by(:username => params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    session.options[:expire_after] = 2592000 unless params['remember'].nil?
    redirect "/home"
  else
    erb :'session/login', :layout => false
  end
end

get '/home' do
  if (session[:user_id].nil?)
    redirect "/"
  else
    erb :'home/index'
  end
end

get '/logout' do
  session.clear
  erb :'session/login', :layout => false
end
