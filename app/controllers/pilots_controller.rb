require 'rack-flash'

class PilotsController < ApplicationController
  use Rack::Flash

  #-----------------CREATE-----------------

  get '/signup' do
    if logged_in?
      redirect to "/"
    else
      erb :'pilots/create_pilot'
    end
  end

  post '/signup' do
    if params.any? {|p| params[p].empty? || params[p] == "" || params[p] == " "}
      flash[:message] = 'Hey, fill out all fields Airman!'
      redirect to "/signup"
    else
      @pilot = Pilot.create(username: params[:username],
      branch: params[:branch],
      rank: params[:rank],
      victories: params[:victories],
      email: params[:email],
      password: params[:password])
      session[:id] = @pilot.id
      session[:username] = @pilot.username
      redirect to "/"
    end

    #------------------READ------------------

    get '/pilot/:slug' do
      @username = username
      @pilot = Pilot.find_by_slug(params[:slug])
      erb :'pilots/show_pilot'
    end

    get '/roster' do
      if logged_in?
        @username = username
        @pilots = Pilot.all
        erb :'pilots/roster'
      else
        redirect to "/login"
      end
    end

    #-----------------UPDATE-----------------

    get '/pilot/:slug/edit' do
      if logged_in?
        @username = username
        @pilot = Pilot.find(params[:slug])
        if @pilot.id == current_user.id
          erb :'pilots/edit_pilot'
        end
      else
        redirect to "/login"
      end
    end

    patch '/pilot/:slug' do
      @pilot = Pilot.find(params[:slug])
      if params.any? {|p| params[p].empty? || params[p] == "" || params[p] == " "}
        flash[:message] = 'Hey, fill out all fields Airman!'
        redirect to "/pilot/#{@pilot.slug}/edit"
      else
        @pilot.content = (params[:content])
        @pilot.branch = (params[:branch])
        @pilot.rank = (params[:rank])
        @pilot.victories = (params[:victories])
        @pilot.email = (params[:email])
        @pilot.save
        redirect to "/roster"
      end
    end

    #-----------------DELETE-----------------

    delete '/pilot/:slug/delete' do
      if logged_in?
        @pilot = Pilot.find_by_id(params[:slug])
        if @pilot.id == current_user.id
          @pilot.delete
        end
        redirect to '/roster'
      else
        flash[:message] = "You don't have that level of clearance!"
        redirect to '/roster'
      end
    end
  end
