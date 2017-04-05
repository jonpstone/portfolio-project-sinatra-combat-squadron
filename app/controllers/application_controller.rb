require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  #------------------INDEX-----------------

  get '/' do
    @username = username
    erb :index
  end

  #-----------------SESSIONS---------------

  get '/login' do
    if logged_in?
      redirect to "/"
    else
      erb :'pilots/login'
    end
  end

  post '/login' do
    pilot = Pilot.find_by(username: params[:username])
    if pilot && pilot.authenticate(params[:password])
      session[:id] = pilot.id
      redirect to "/"
    else
      flash[:message] = "Restricted area! Check in with the MPs."
      redirect to "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  #-----------------HELPERS----------------

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      Pilot.find(session[:id])
    end

    def username
      session[:username]
    end
  end

  #-----------------GRAPHIC----------------



end
