class FiguresController < ApplicationController

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do

    @figure = Figure.create(params[:figure])
    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(name: params["landmark"]["name"])
      @figure.landmarks << landmark
    end

    if !params["title"]["name"].empty?
      title = Title.create(name: params["title"]["name"])
      @figure.titles << title
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"/figures/edit"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])
    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(name: params["landmark"]["name"])
      @figure.landmarks << landmark
    end
    if !params["title"]["name"].empty?
      title = Title.create(name: params["title"]["name"])
      @figure.titles << title
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end


end
