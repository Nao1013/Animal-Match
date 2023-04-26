class Facility::CommentsController < ApplicationController

  def create
    @animal = Animal.find(params[:animal_id])
    @comment = current_facility.comments.new(comment_params)
    @comment.animal_id = @animal.id
    @comment.save
    # redirect_to facility_animal_path(@animal)
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    # redirect_to facility_animal_path(params[:animal_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
