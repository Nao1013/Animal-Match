class Facility::AnimalsController < ApplicationController

  def new
    @animal = Animal.new
  end

  def create
    @animal = current_facility.animals.build(animal_params)
    tags=params[:animal][:tag].split(',')
    if @animal.save
      # @animalをつけることanimalモデルの情報を.save_tagsに引き渡してメソッドを走らせることができる
      @animal.save_tags(tags)
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
    @tags = @animal.tags.pluck(:tag).join(',')  # タグ用コード
  end

  def edit
    @animal = Animal.find(params[:id])
    @tags=@animal.tags.pluck(:tag).join(',')
  end

  def update
    @animal = Animal.find(params[:id])
    tags=params[:animal][:tag].split(',')
    if @animal.update(animal_params)
      @animal.save_tags(tags)
      redirect_to facility_animal_path(@animal),notice:'編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    animal = Animal.find(params[:id])
    animal.destroy
    redirect_to facility_animals_path, notice:'削除しました'
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, images: [])
  end

end
