class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
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
