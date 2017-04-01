class PilotsController < ApplicationController

  #----------------SESSIONS--------------

  get '/login' do
    if logged_in?
      redirect to "/opsroom"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    pilot = Pilot.find_by(username: params[:username])
    if pilot && pilot.authenticate(params[:password])
      session[:id] = pilot.id
      redirect to "/opsroom"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  #-----------------CREATE-----------------

  get '/signup' do ### CREATE USER
    if logged_in?
      redirect to "/opsroom"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params["username"].empty? || params["email"].empty? || params["password"].empty?
      redirect to "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = @user.id
      session[:username] = @user.username
      redirect to "/opsroom"
    end
  end
