class Facility::AnimalsController < ApplicationController

  def new
    @animal = Animal.new
  end

  def create
    @animal = current_facility.animals.build(animal_params)
    tag_list=params[:animal][:name].split('#')
    if @animal.save
      @animal.save_tag(tag_list)
      redirect_to facility_animal_path(@animal),notice:'投稿しました'
    else
      render 'new'
    end
  end

  def index
    @animals = Animal.all
  end

  def show
    @animal = Animal.find(params[:id])
    @animal_tags = @animal.tags
  end

  def edit
    @animal = Animal.find(params[:id])
    @tag_list=@animal.tags.pluck(:name).join('#')
  end

  def update
    @animal = Animal.find(params[:id])
    tag_list=params[:animal][:name].split('#')
    if @animal.update(animal_params)
      @animal.save_tag(tag_list)
      redirect_to facility_animal_path(@animal),notice:'編集しました'
    else
      render 'edit'
    end
  end

  def destroy

  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, images: [])
  end

end
