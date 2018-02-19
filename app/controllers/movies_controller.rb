class MoviesController < ApplicationController
  # @all_ratings = ['G','PG','PG-13','R']
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G','PG','PG-13','R']
    # if session[:ratings] == nil
    #   # @movies = Movie.all
    #   session[:ratings] = {'G' => 1, 'PG' => 1, 'PG-13' => 1, 'R' => 1}
    #   params[:ratings] = session[:ratings]
    # elsif params[:ratings] == nil
    #   params[:ratings] = session[:ratings]
    # end
    
    if params[:ratings] == nil
      params[:ratings] = {'G' => 1, 'PG' => 1, 'PG-13' => 1, 'R' => 1}
      # //session[:ratings] = params[:ratings]
    end
    # elsif params[:ratings] == nil
    #   # params[:ratings] = {'G' => 0, 'PG' => 0, 'PG-13' => 0, 'R' => 0}
    #   params[:ratings] = session[:ratings]
    # end
      
    # else
    # params[:ratings] = session[:ratings]
    @movies = Movie.where(rating: params[:ratings].keys)
    # session[:ratings] = params[:ratings]
    # end
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    # @all_ratings = ['G','PG','PG-13','R']
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def sort_title
    @all_ratings = ['G','PG','PG-13','R']
    @movies = Movie.order('title')
    params[:title_header] = 'hilite'
    params[:release_date_header] = ''
    params[:ratings] = {'G' => 1, 'PG' => 1, 'PG-13' => 1, 'R' => 1}
    render 'index'
  end
  
  def sort_release_date
    @all_ratings = ['G','PG','PG-13','R']
    @movies = Movie.order('release_date')
    params[:title_header] = ''
    params[:release_date_header] = 'hilite'
    params[:ratings] = {'G' => 1, 'PG' => 1, 'PG-13' => 1, 'R' => 1}
    render 'index'
  end
end
