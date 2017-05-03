require 'rack-flash'

class PilotsController < ApplicationController
  use Rack::Flash

  #-----------------CREATE-----------------

  get '/enlist' do
    if logged_in?
      flash[:message] = "You have your wings already!"
      redirect to "/"
    else
      @pilot = Pilot.new
      erb :'pilots/create_pilot'
    end
  end

  post '/enlist' do
    @pilot = Pilot.new(params[:pilot])
    if @pilot.save
      session[:pilot_id] = @pilot.id
      redirect to "/"
    else
      flash.now[:message] =  @pilot.errors.full_messages.join(', ')
      erb :'pilots/create_pilot'
    end
  end

  #------------------READ------------------

  get '/pilots/:id' do
    if logged_in?
      @pilot = Pilot.find(params[:id])
      erb :'pilots/show_pilot'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  get '/pilots/:id/session' do
    if logged_in?
      @pilot = Pilot.find(session[:pilot_id])
      erb :'pilots/show_session'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  get '/roster' do
    if logged_in?
      @pilots = Pilot.all
      erb :'pilots/show_roster'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to "/login"
    end
  end

  #-----------------UPDATE-----------------

  get '/pilots/:id/edit' do
    if logged_in?
      Pilot.find(session[:pilot_id])
      @pilot = Pilot.find(session[:pilot_id])
      if @pilot.id == current_user.id
        erb :'pilots/edit_pilot'
      end
    else
      flash[:message] = "I don't see enough rank on your shoulders Airman!"
      redirect to "/login"
    end
  end

  patch '/pilots/:id' do
    @pilot = Pilot.find(session[:pilot_id])
    if @pilot.update(params[:pilot])
      @pilot.save
      redirect to "/roster"
    else
      flash.now[:message] = @pilot.errors.full_messages.join(', ')
      erb :'pilots/edit_pilot'
    end
  end

  #-----------------DELETE-----------------

  delete '/pilots/:id/delete' do
    if logged_in?
      @pilot = Pilot.find(session[:pilot_id])
      if @pilot.id == current_user.id
        @pilot.delete
      end
      session.clear
      redirect to '/login'
    else
      flash[:message] = "I don't see enough rank on your shoulders Airman!"
      redirect to '/'
    end
  end
end
