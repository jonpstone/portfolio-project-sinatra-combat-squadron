class PilotsController < ApplicationController
  use Rack::Flash

  #-----------------CREATE-----------------

  get '/enlist' do
    if logged_in?
      flash[:notice] = 'You have your wings already!'
      redirect to "/"
    else
      erb :'pilots/create_pilot'
    end
  end

  post '/enlist' do
    params.each do |k, v|
      if v.blank?
        flash[:notice] = 'Hey, fill out all fields Airman!'
        redirect to "/enlist"
      else
        @pilot = Pilot.create(params[:pilot])
        session[:id] = @pilot.id
        session[:username] = @pilot.username
        @pilot.save
        redirect to "/"
      end
    end
  end

  #------------------READ------------------

  get '/pilots/:id' do
    if logged_in?
      @pilot = Pilot.find(params[:id])
      erb :'pilots/show_pilot'
    else
      flash[:notice] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  get '/pilots/:id/session' do
    if logged_in?
      @pilot = Pilot.find(session[:id])
      erb :'pilots/show_session'
    else
      flash[:notice] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  get '/roster' do
    if logged_in?
      @pilots = Pilot.all
      erb :'pilots/show_roster'
    else
      flash[:notice] = "You don't have that kind of authority Airman!"
      redirect to "/login"
    end
  end

  #-----------------UPDATE-----------------

  get '/pilots/:id/edit' do
    if logged_in?
      Pilot.find(session[:id])
      @pilot = Pilot.find(session[:id])
      if @pilot.id == current_user.id
        erb :'pilots/edit_pilot'
      end
    else
      flash[:notice] = "I don't see enough rank on your shoulders Airman!"
      redirect to "/login"
    end
  end

  patch '/pilots/:id' do
    @pilot = Pilot.find(session[:id])
    @pilot.update(params[:pilot])
    @pilot.save
    redirect to "/"
  end

    #-----------------DELETE-----------------

  delete '/pilots/:id/delete' do
    if logged_in?
      @pilot = Pilot.find(session[:id])
      if @pilot.id == current_user.id
        @pilot.delete
      end
      redirect to '/'
    else
      flash[:notice] = "I don't see enough rank on your shoulders Airman!"
      redirect to '/'
    end
  end
end
