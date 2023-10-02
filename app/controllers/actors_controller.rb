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
    @actors = Actor.new
    @actors.name = params.fetch("actor_name")
    @actors.dob = params.fetch("actor_dob")
    @actors.bio = params.fetch("actor_bio")
    @actors.image = params.fetch("actor_image")
    
    if @actors.valid?
      @actors.save
      redirect_to("/actors", { :notice => "Actor created successfully." })
    else
      redirect_to("/actors", { :notice => "Actor failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @actors = Actor.where({ :id => the_id }).at(0)
    
    @actors.name = params.fetch("actor_name")
    @actors.dob = params.fetch("actor_dob")
    @actors.bio = params.fetch("actor_bio")
    @actors.image = params.fetch("actor_image")
    
    if @actors.valid?
      @actors.save
      redirect_to("/actors", { :notice => "Actor updated successfully." })
    else
      redirect_to("/actors", { :notice => "Actor failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @actors = Actor.where({ :id => the_id }).at(0)

    @actors.destroy

    redirect_to("/actors", { :notice => "Actor deleted successfully."})
  end
end
