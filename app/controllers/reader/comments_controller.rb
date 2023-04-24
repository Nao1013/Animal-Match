class Reader::CommentsController < ApplicationController
  
  def create
    @animal = Animal.find(params[:animal_id])
    @comment = current_reader.comments.new(comment_params)
    @comment.animal_id = @animal.id
    @comment.save
    #redirect_to reader_animal_path(animal)
  end
  
  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
