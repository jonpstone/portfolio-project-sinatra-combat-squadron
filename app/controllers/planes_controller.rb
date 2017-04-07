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
    if params.any? {|p| params[p].empty? || params[p] == "" || params[p] == " "}
      flash[:message] = "Hey, fill out all fields Airman!"
      redirect to '/planes/new'
    else
      @plane = Plane.create(name: params[:name],
      manufacturer: params[:manufacturer],
      top_speed: params[:top_speed],
      ceiling: params[:ceiling],
      type: params[:type])
      redirect to '/hangar'
    end
  end

  #------------------READ------------------

  get '/planes/:id/' do
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
      @planes = Plane.all
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
      if @plane.pilot_id == current_user
        erb :'planes/edit_weapon'
      end
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  patch '/planes/:id' do
    @plane = Plane.find(params[:id])
    if params.any? {|p| params[p].empty? || params[p] == "" || params[p] == " "}
      flash[:message] = "Hey, fill out all fields Airman!"
      redirect to "/planes/#{@plane.id}/edit"
    else
      @plane.name = (params[:name])
      @plane.manufacturer = (params[:manufacturer])
      @plane.top_speed = (params[:top_speed])
      @plane.ceiling = (params[:ceiling])
      @plane.type = (params[:type])
      @plane.save
      redirect to '/hangar'
    end
  end

  #-----------------DELETE-----------------

  delete '/planes/:id/delete' do
    if logged_in?
      @plane = Plane.find(params[:id])
      if @plane.pilot_id == current_user.id
        @plane.delete
      end
      redirect to '/hangar'
    else
      flash[:message] = "I don't see enough rank on your shoulders Airman!"
      redirect to '/hangar'
    end
  end
end
