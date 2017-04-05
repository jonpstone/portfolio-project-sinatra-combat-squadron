require 'rack-flash'

class PilotsController < ApplicationController
  use Rack::Flash

  #-----------------CREATE-----------------

  get '/enlist' do
    if logged_in?
      flash[:message] = 'You have your wings already!'
      redirect to "/"
    else
      erb :'pilots/create_pilot'
    end
  end

  post '/enlist' do
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
  end

    #------------------READ------------------

    get '/pilots/:slug' do
      @pilot = Pilot.find_by_slug(params[:slug])
      erb :'pilots/show_pilot'
    end

    get '/roster' do
      if logged_in?
        @pilots = Pilot.all
        erb :'pilots/roster'
      else
        redirect to "/login"
      end
    end

    #-----------------UPDATE-----------------

    get '/pilots/:slug/edit' do
      if logged_in?
        @pilot = Pilot.find(params[:slug])
        if @pilot.id == current_user.id
          erb :'pilots/edit_pilot'
        end
      else
        redirect to "/login"
      end
    end

    patch '/pilots/:slug' do
      @pilot = Pilot.find(params[:slug])
      if params.any? {|p| params[p].empty? || params[p] == "" || params[p] == " "}
        flash[:message] = 'Hey, fill out all fields Airman!'
        redirect to "/pilots/#{@pilot.slug}/edit"
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

    delete '/pilots/:slug/delete' do
      if logged_in?
        @pilot = Pilot.find_by_id(params[:slug])
        if @pilot.id == current_user.id
          @pilot.delete
        end
        redirect to '/roster'
      else
        flash[:message] = "I don't see enough rank on your shoulders Airman!"
        redirect to '/roster'
      end
    end
  end
