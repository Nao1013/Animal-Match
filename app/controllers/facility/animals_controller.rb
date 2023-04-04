class Facility::AnimalsController < ApplicationController

  def new
    @animal = Animal.new
  end

  def create
    @animal = current_facility.animals.build(animal_params)
    tags=params[:animal][:tag].split(',').map(&:strip).uniq
    if @animal.save
      # @animalをつけることanimalモデルの情報を.save_tagsに引き渡してメソッドを走らせることができる
      @animal.save_tags(tags)
      redirect_to facility_animal_path(@animal),notice:'投稿しました'
    else
      render 'new'
    end
  end

  def index
    @genres = Genre.all
    @animals = params[:name].present? ? Genre.find(params[:name]).animals : Animal.all
    # @animals = Tag.search(params[:tag]
    @facility = current_facility
  end

  def show
    @animal = Animal.find(params[:id])
    @tags = @animal.tags.pluck(:tag)  # タグ用コード
  end

  def edit
    @animal = Animal.find(params[:id])
    @tags=@animal.tags.pluck(:tag).join(',')
  end

  def update
    @animal = Animal.find(params[:id])
    tags=params[:animal][:tag].split(',').map(&:strip).uniq
    if @animal.update(animal_params)
      @animal.update_tags(tags)
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

  def search
    if (params[:keyword])[0] == ','
      @animals = Tag.search(params[:keyword]).order('created_at DESC')
    else
      @animals = Animal.search(params[:keyword]).order('created_at DESC')
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, images: [], genre_ids: [])
  end

end
