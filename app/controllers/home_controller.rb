class HomeController < ApplicationController
  def index
    @meal_plan = current_user.meal_plans
      .where.not(date: nil)
      .order(created_at: :desc)
      .first

    return unless @meal_plan

    meal_items = @meal_plan.meal_items
      .joins(:my_menu)
      .includes(:my_menu)
      .where(
        "my_menus.last_cooked_at IS NULL OR my_menus.last_cooked_at < ?",
        @meal_plan.date
      )

    # 🔑 どの genre を使うか明示する
    @meal_items = meal_items.group_by { |item| item.my_menu.genre }
  end
end
