require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
    enable :sessions
  end

  #------------------INDEX-----------------

  get '/' do
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
      session[:pilot_id] = pilot.id
      session[:username] = pilot.username
      redirect to "/"
    else
      flash[:message] = "Restricted area! Check in with the MPs or enlist!"
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
      !!current_user
    end

    def current_user
      @current_user ||= Pilot.find_by(id: session[:pilot_id]) if session[:pilot_id]
    end

    def username
      session[:username]
    end
  end
end
