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
        @pilot = Pilot.create(
        username: params[:username],
        branch: params[:branch],
        rank: params[:rank],
        victories: params[:victories],
        email: params[:email],
        password: params[:password])
        binding.pry
        rtherh
        session[:id] = @pilot.id
        session[:username] = @pilot.username
        redirect to "/"
      end
    end
  end

  #------------------READ------------------

  get '/pilots/:id' do
    @pilot = Pilot.find(session[:id])
    binding.pry
    erb :'pilots/show_pilot'
  end

  get '/roster' do
    if logged_in?
      @pilots = Pilot.all
      erb :'pilots/show_roster'
    else
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
    @pilot.username = (params[:username])
    @pilot.branch = (params[:branch])
    @pilot.rank = (params[:rank])
    @pilot.victories = (params[:victories])
    @pilot.email = (params[:email])
    @pilot.save
    redirect to "/roster"
  end

    #-----------------DELETE-----------------

  delete '/pilots/:id/delete' do
    if logged_in?
      @pilot = Pilot.find(session[:id])
      if @pilot.id == current_user.id
        @pilot.delete
      end
      redirect to '/roster'
    else
      flash[:notice] = "I don't see enough rank on your shoulders Airman!"
      redirect to '/roster'
    end
  end
end
