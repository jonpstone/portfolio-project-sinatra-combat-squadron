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
    if params[:weapon].values.any? {|v| v.empty? or v == ""}
      flash[:message] = "Fill out all fields Airman!"
      redirect to '/weapons/new'
    else
      @weapon = Weapon.create(params[:weapon])
      @weapon.save
      redirect to '/armory'
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
    if params[:weapon].values.any? {|v| v.empty? or v == ""}
      flash[:message] = "A weapon needs a name. Fill out all fields Airman!"
      redirect to "/weapons/#{@weapon.id}/edit"
    else
      @weapon.update(params[:weapon])
      @weapon.save
      redirect to '/armory'
    end
  end

  #-----------------DELETE-----------------

  delete '/weapons/:id/delete' do
    if logged_in?
      @weapon = Weapon.find(params[:id])
      @weapon.delete
      redirect to '/armory'
    else
      flash[:message] = "I don't see enough rank on your shoulders Airman!"
      redirect to '/armory'
    end
  end
end
