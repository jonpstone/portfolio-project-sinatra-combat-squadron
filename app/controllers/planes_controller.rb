require 'rack-flash'

class PlanesController < ApplicationController
  use Rack::Flash

  #-----------------CREATE-----------------

  get '/planes/new' do
    if logged_in?
      erb :'planes/create_plane'
    else
      flash[:notice] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  post '/planes' do
    params.each do |k, v|
      if v.blank?
        flash[:notice] = "Hey, fill out all fields Airman!"
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
  end

  #------------------READ------------------

  get '/planes/:id' do
    if logged_in?
      @plane = Plane.find(params[:id])
      erb :'planes/show_plane'
    else
      flash[:notice] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  get '/hangar' do
    if logged_in?
      @plane = Plane.all
      erb :'planes/show_hangar'
    else
      flash[:notice] = "Restricted area! Check in with the MPs!"
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
      flash[:notice] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  patch '/planes/:id' do
    @plane = Plane.find(params[:id])
    @plane.name = (params[:name])
    @plane.manufacturer = (params[:manufacturer])
    @plane.top_speed = (params[:top_speed])
    @plane.ceiling = (params[:ceiling])
    @plane.type = (params[:type])
    @plane.save
    redirect to '/hangar'
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
      flash[:notice] = "I don't see enough rank on your shoulders Airman!"
      redirect to '/hangar'
    end
  end
end
