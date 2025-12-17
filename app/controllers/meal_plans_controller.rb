class MealPlansController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @meal_plan = MealPlan.new
    @my_menus = current_user.my_menus.order(last_cooked_at: :desc)   # メニュー選択用
  end

  def confirm
    menu_ids = params[:my_menu_ids]

    @selected_menus = current_user.my_menus.where(id: menu_ids)
    @meal_plan = current_user.meal_plans.new

    render turbo_stream: turbo_stream.replace(
      "modal",
      partial: "meal_plans/confirm_modal"
    )
  end

  def show
    @meal_plan = current_user.meal_plans.find(params[:id])
    @meal_items_by_genre =
      @meal_plan.meal_items.includes(:my_menu).group_by(&:genre)
  end

  def create
    @meal_plan = current_user.meal_plans.create!(date: Date.current)

    params[:meal_plan][:my_menu_ids].each do |menu_id|
      menu = current_user.my_menus.find(menu_id)

      @meal_plan.meal_items.create!(
        my_menu: menu,
        genre: menu.genre   # ← ★これが全て
      )
    end

    redirect_to @meal_plan, notice: "献立を作成しました"
  end


  private

  def meal_plan_params
    params.require(:meal_plan).permit(:date)
  end
end
