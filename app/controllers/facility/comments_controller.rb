class Facility::CommentsController < ApplicationController

  def create
    animal = Animal.find(params[:animal_id])
    comment = current_facility.comments.new(comment_params)
    comment.animal_id = animal.id
    comment.save!
    redirect_to facility_animal_path(animal)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
