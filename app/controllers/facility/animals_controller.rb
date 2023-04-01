class Facility::AnimalsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def show
    @animal = Animal.find(params[:id])
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.create
    @animal.facility_id = current_facility.id
    if @animal.save
      redirect_to facility_animal_path(@animal)
    else
      render 'new'
    end
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def update
    @animal = Animal.find(params[:id])
    @animal.facility_id = current_facility.id
    if @animal.update(animal_params)
      redirect_to facility_animal_path(@animal)
    end
  end

  def destroy

  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, images: [])
  end

end
