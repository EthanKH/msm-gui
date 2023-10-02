class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    @directors = Director.new
    @directors.name = params.fetch("director_name")
    @directors.dob = params.fetch("director_dob")
    @directors.bio = params.fetch("director_bio")
    @directors.image = params.fetch("director_image")
    
    if @directors.valid?
      @directors.save
      redirect_to("/directors", { :notice => "Director created successfully." })
    else
      redirect_to("/directors", { :notice => "Director failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @directors = Director.where({ :id => the_id }).at(0)
    
    @directors.name = params.fetch("director_name")
    @directors.dob = params.fetch("director_dob")
    @directors.bio = params.fetch("director_bio")
    @directors.image = params.fetch("director_image")
    
    if @directors.valid?
      @directors.save
      redirect_to("/directors", { :notice => "Director updated successfully." })
    else
      redirect_to("/directors", { :notice => "Director failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @directors = Director.where({ :id => the_id }).at(0)

    @directors.destroy

    redirect_to("/directors", { :notice => "Director deleted successfully."})
  end
end
