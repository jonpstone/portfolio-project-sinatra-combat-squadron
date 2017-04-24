require 'rack-flash'

class WeaponsController < ApplicationController
  use Rack::Flash

  #-----------------CREATE-----------------

  get '/weapons/new' do
    if logged_in?
      erb :'weapons/create_weapon'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  post '/weapons' do
    params[:weapon].any? do |k, v|
      if v == "" || v == " "
        flash[:message] = "Fill out all fields Airman!"
        redirect to '/weapons/new'
      else
        @weapon = Weapon.create(params[:weapon])
        @weapon.save
        redirect to '/armory'
      end
    end
  end

  #------------------READ------------------

  get '/weapons/:id' do
    if logged_in?
      @weapon = Weapon.find(params[:id])
      erb :'weapons/show_weapon'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  get '/armory' do
    if logged_in?
      @weapons = Weapon.all
      erb :'weapons/show_armory'
    else
      flash[:message] = "Restricted area! Check in with the MPs!"
      redirect to '/login'
    end
  end

  #-----------------UPDATE-----------------

  get '/weapons/:id/edit' do
    if logged_in?
      @weapon = Weapon.find(params[:id])
      erb :'weapons/edit_weapon'
    else
      flash[:message] = "You don't have that kind of authority Airman!"
      redirect to '/login'
    end
  end

  patch '/weapons/:id' do
    @weapon = Weapon.find(params[:id])
      params[:weapon].any? do |k, v|
      if v == "" || v == " "
        flash[:message] = "A weapon needs a name. Fill out all fields Airman!"
        redirect to "/pilots/#{@weapon.id}/edit"
      else
        @weapon.update(params[:weapon])
        @weapon.save
        redirect to '/armory'
      end
    end
  end

  #-----------------DELETE-----------------

  delete '/weapons/:id/delete' do
    if logged_in?
      @weapon = Weapon.find(params[:id])
      if @weapon.pilot_id == current_user.id
        @weapon.delete
      end
      redirect to '/armory'
    else
      flash[:message] = "I don't see enough rank on your shoulders Airman!"
      redirect to '/armory'
    end
  end
end
