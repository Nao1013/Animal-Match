class Reader::SearchsController < ApplicationController
  
  def search
    # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    # 選択したモデルがfacilityだったら
    if model == 'facility'
      # 選択した検索方法がが完全一致だったら
      # if method == 'perfect'
      #   Facility.where(facility_name: content)
      # 選択した検索方法がが部分一致だったら
      # else
        Facility.where('facility_name LIKE ?', '%'+content+'%')
      # end
    # 選択したモデルがanimalだったら
    elsif model == 'animal'
      # if method == 'perfect'
      #   Animal.where(introduct: content)
      # else
        Animal.where('introduct LIKE ?', '%'+content+'%')
      # end
    end
  end
  
end
