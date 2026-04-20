class RecipesController < ApplicationController
  def index
    service = RakutenRecipeApiService.new
    
    if params[:keyword].present?
      # 1. 入力されたワードからカテゴリIDを探す
      category_id = service.find_category_id_by_query(params[:keyword])
      
      if category_id
        # 2. IDが見つかれば、そのランキングを取得
        @recipes = service.fetch_ranking(category_id)
      else
        @recipes = []
        flash.now[:alert] = "「#{params[:keyword]}」に一致するカテゴリが見つかりませんでした。"
      end
    else
      # キーワードがない場合は総合ランキングを表示
      @recipes = service.fetch_ranking
    end
  end
end
