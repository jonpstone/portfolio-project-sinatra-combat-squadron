require './config/environment'

class ApplicationController < Sinatra::Base

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

  #-----------------HELPERS----------------

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

    def username
      session[:username]
    end
  end
end
