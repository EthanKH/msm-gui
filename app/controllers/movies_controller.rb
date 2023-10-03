class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    @movies = Movie.new
    @movies.title = params.fetch("movie_title")
    @movies.year = params.fetch("movie_year")
    @movies.duration = params.fetch("movie_duration")
    @movies.description = params.fetch("movie_description")
    @movies.image = params.fetch("movie_image")
    @movies.director_id = params.fetch("director_id")
    
    if @movies.valid?
      @movies.save
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      redirect_to("/movies", { :notice => "Movie failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @movies = Movie.where({ :id => the_id }).at(0)
    
    @movies.title = params.fetch("movie_title")
    @movies.year = params.fetch("movie_year")
    @movies.duration = params.fetch("movie_duration")
    @movies.description = params.fetch("movie_description")
    @movies.image = params.fetch("movie_image")
    @movies.director_id = params.fetch("director_id")
    
    if @movies.valid?
      @movies.save
      redirect_to("/movies/#{@movies.id}")
    else
      redirect_to("/movies/#{@movies.id}")
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @movies = Movie.where({ :id => the_id }).at(0)

    @movies.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."})
  end
end
