class MoviesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  
  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie = find_movie
    render json: movie, status: :ok
  end

  def create
    movie = Movie.create!(movie_params)
    render json: movie, status: :created
  end

  private

  def find_movie
    movie = Movie.find(params[:id])
  end

  def movie_params
    params.permit(:title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director)
  end

  def render_unprocessable_entity(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
  
end
