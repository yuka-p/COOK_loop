class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_menus = current_user.my_menus

    # 今日の献立を取得 or 作成
    @today_meal_plan = current_user.meal_plans.find_or_create_by(date: Date.current)

    # 今日の献立に紐づく MealItem をジャンルごとにグループ化
    @meal_items = @today_meal_plan
                    .meal_items
                    .includes(:my_menu)
                    .group_by { |item| item.my_menu.genre }

    # 今日の献立にまだ追加されていないマイメニューID
    added_menu_ids = @today_meal_plan.meal_items.pluck(:my_menu_id)

    # おすすめメニュー（追加されていない&直近で作っていないもの優先）
    @recommended_menus =
      current_user
        .my_menus
        .where.not(id: added_menu_ids)          # まだ献立に入っていないもの
        .sorted("last_cooked_desc")            # last_cooked_at nil や古い順
        .limit(3)
  end
end
