require 'rack-flash'

class PlanesController < ApplicationController
  use Rack::Flash

  #-----------------CREATE-----------------

  get '/planes/new' do
    if logged_in?
      erb :'planes/create_plane'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  post '/planes' do
    params[:plane].any? do |k, v|
      if v == "" || v == " "
        flash[:message] = "Fill out all fields Airman!"
        redirect to '/planes/new'
      else
        @plane = Plane.create(params[:plane])
        @plane.save
        redirect to '/hangar'
      end
    end
  end

  #------------------READ------------------

  get '/planes/:id' do
    if logged_in?
      @plane = Plane.find(params[:id])
      erb :'planes/show_plane'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  get '/hangar' do
    if logged_in?
      @plane = Plane.all
      erb :'planes/show_hangar'
    else
      flash[:message] = "Restricted area! Check in with the MPs!"
      redirect to '/login'
    end
  end

  #-----------------UPDATE-----------------

  get '/planes/:id/edit' do
    if logged_in?
      @plane = Plane.find(params[:id])
      if @plane.pilot_ids.include?(current_user.id)
        erb :'planes/edit_plane'
      else
        flash[:message] = "You don't have that kind of authority Airman!"
        redirect to '/hangar'
      end
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  patch '/planes/:id' do
    @plane = Plane.find(params[:id])
    params[:plane].any? do |k, v|
      if v == "" || v == " "
        flash[:message] = "A plane needs a name. Fill out all fields Airman!"
        redirect to "/pilots/#{@plane.id}/edit"
      else
        @plane.update(params[:plane])
        @plane.save
        redirect to '/hangar'
      end
    end
  end

  #-----------------DELETE-----------------

  delete '/planes/:id/delete' do
    if logged_in?
      @plane = Plane.find(params[:id])
      if @plane.pilot_ids.include?(current_user.id)
        @plane.delete
      end
      redirect to '/hangar'
    else
      flash[:message] = "I don't see enough rank on your shoulders Airman!"
      redirect to '/hangar'
    end
  end
end
