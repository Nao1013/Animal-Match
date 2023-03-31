class Facility::AnimalsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def show

  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.facility_id = current_facility.id
    if @animal.save
      redirect_to facility_animals_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  private

  def animal_params
    params.require(:animal).permit(:name, :images [], :introduct, :is_decided)
  end

end
