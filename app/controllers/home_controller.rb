class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_menus = current_user.my_menus

    # 今日の献立を取得 or 作成
    @today_meal_plan = current_user.meal_plans.find_or_create_by(date: Date.current)

    # 今日の献立に紐づく MealItem をジャンルごとにグループ化
    @meal_items = current_user.meal_plans
                              .includes(meal_items: :my_menu)
                              .flat_map(&:meal_items)
                              .group_by(&:genre)

    # 今日の献立にまだ追加されていないマイメニューID
    added_menu_ids = @today_meal_plan.meal_items.pluck(:my_menu_id)

    # おすすめメニュー（追加されていない&直近で作っていないもの優先）
    @recommended_menus =
      current_user
        .my_menus
        .where.not(id: added_menu_ids)
        .order(Arel.sql("COALESCE(last_cooked_at, '1970-01-01') ASC, RANDOM()"))
        .limit(3)
  end
end
