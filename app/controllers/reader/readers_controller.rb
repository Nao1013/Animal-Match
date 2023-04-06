class Reader::ReadersController < ApplicationController
  def edit
    @reader = Reader.find(params[:id])
  end

  def show
    @reader = Reader.find(params[:id])
  end
  
  def update
    @reader = Reader.find(params[:id])
    if @reader.update(reader_params)
      redirect_to reader_reader_path(@reader)
    else
      render 'edit'
    end
  end
  
  private
  
  def reader_params
    params.require(:reader).permit(:first_name, :last_name, :user_name, :introduct, :prefecture, :profile_image)
  end
end
