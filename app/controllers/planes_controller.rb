require 'rack-flash'

class PlanesController < ApplicationController
  use Rack::Flash

  #-----------------CREATE-----------------

  get '/planes/new' do
    if logged_in?
      @username = username
      erb :'planes/create_planes'
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
      email: params[:email],
      type: params[:type])
      redirect to '/hangar'
    end

  #------------------READ------------------

  get '/plane/:id/' do
    if logged_in?
      @username = username
      @plane = Plane.find(params[:id])
      erb :'planes/show_plane'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  get '/hangar' do
    if logged_in?
      @pilot = Pilot.all
      @planes = Plane.all
      erb :'planes/show_hangar'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  #-----------------UPDATE-----------------

  get '/plane/:id/edit' do
    if logged_in?
      @username = username
      @plane = Plane.find(params[:id])
      if @plane.pilot_id == current_user
        @plane.delete
      end
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  patch '/plane/:id' do
    @plane = Plane.find(params[:id])
    if params.any? {|p| params[p].empty? || params[p] == "" || params[p] == " "}
      flash[:message] = "Hey, fill out all fields Airman!"
      redirect to "/tweets/#{@plane.id}/edit"
    else
      @plane.name = (params[:name])
      @plane.manufacturer = (params[:manufacturer])
      @plane.top_speed = (params[:top_speed])
      @plane.ceiling = (params[:ceiling])
      @plane.type = (params[:type])
      @plane.save
      redirect to '/hangar'
    end

  #-----------------DELETE-----------------

  delete '/plane/:id/delete' do
    if logged_in?
      @plane = Plane.find(params[:id])
      if @plane.pilot_id == current_user.id
        @plane.delete
      end
      redirect to '/hangar'
    else
      redirect to '/hangar'
    end
  end
end
