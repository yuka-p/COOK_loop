# encoding: utf-8

class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    service = RakutenRecipeApiService.new

    if params[:keyword].present?
      begin
        category_id = service.find_category_id_by_query(params[:keyword])

        if category_id
          @recipes = service.fetch_ranking(category_id)
        else
          @recipes = []
          flash.now[:alert] = "「#{params[:keyword]}」に一致するカテゴリが見つかりませんでした。"
        end
      rescue => e
        @recipes = []
        flash.now[:alert] = "レシピ検索中にエラーが発生しました。後で再度お試しください。"
        Rails.logger.error("Recipe API Error: #{e.message}")
      end
    else
      @recipes = service.fetch_ranking
    end
  end
end
