class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_menus = current_user.my_menus

    @today_meal_plan = current_user.meal_plans.find_or_create_by(date: Date.current)

    @meal_items = current_user.meal_plans
                              .includes(meal_items: :my_menu)
                              .flat_map(&:meal_items)
                              .reject(&:cooked) 
                              .group_by(&:genre)

    added_menu_ids = @today_meal_plan.meal_items.pluck(:my_menu_id)

    base_scope = current_user.my_menus.where.not(id: added_menu_ids)

    candidate_menus = base_scope
                        .order(Arel.sql("COALESCE(last_cooked_at, '1970-01-01') ASC"))
                       .limit(10)

    @recommended_menus = candidate_menus.sample(3)
  end
end
