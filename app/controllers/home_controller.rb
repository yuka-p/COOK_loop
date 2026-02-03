class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_menus = current_user.my_menus

    meal_plans = current_user.meal_plans
      .where.not(date: nil)
      .order(created_at: :desc)

    meal_items = MealItem
      .joins(:meal_plan, :my_menu)
      .includes(:my_menu)
      .where(meal_plan: meal_plans)
      .where("my_menus.last_cooked_at IS NULL OR my_menus.last_cooked_at < meal_plans.date")

    @meal_items = meal_items.group_by { |item| item.my_menu.genre }
  end
end
