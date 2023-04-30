class Facility::AnimalsController < ApplicationController
  before_action :authenticate_facility! # ログインしているfacility以外はアクセスできない（ブラウザバッグもできない）
  before_action :ensure_user, only: [:edit, :update, :show]

  def new
    @animal = Animal.new
    @tag = Tag.new
  end

  def create
    @animal = current_facility.animals.new(animal_params)
    tags = params[:animal][:tag].split(',').map(&:strip).uniq
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
    # if params[:tag].present?
    #   @animals = Tag.search(params[:tag]).where(facility_id:current_facility.id)
    # if params[:name].present?
      @animals_dog = Genre.find_by(name: "犬").animals.where(facility_id:current_facility.id)
      @animals_cat = Genre.find_by(name: "猫").animals.where(facility_id:current_facility.id)
    # else
      @animals = current_facility.animals.where(facility_id:current_facility.id)
    # end
    @facility = current_facility
  end

  def show
    @animal = Animal.find(params[:id])
    @comment_reader = Comment.where(animal_id: @animal.id)
    @comment = Comment.new
    # @tags = @animal.tags.pluck(:tag)  # タグ用コード
    
  end

  def edit
    @animal = Animal.find(params[:id])
    @tags=@animal.tags.pluck(:tag).join(',')
  end

  def update
    @animal = Animal.find(params[:id])
    tags = params[:animal][:tag].split(',').map(&:strip).uniq
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
    flash[:alert] = '削除しました'
    redirect_to facility_animals_path
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :introduct, :is_decided, images: [], genre_ids: [])
  end

  # URLに直打ちしたときの制約
  def ensure_user
    @animals = current_facility.animals
    @animal = @animals.find_by(id: params[:id])
    redirect_to root_path unless @animal
  end
  
   # タグのフォーム入力値に対応するストロングパラメータ
   def tag_params
     params.require(:animal).permit(:tag)
   end

end
