class MealPlansController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @meal_plan = MealPlan.new
    @my_menus = current_user.my_menus.order(last_cooked_at: :desc)   # メニュー選択用
  end

  def show
    @meal_plan = current_user.meal_plans.find(params[:id])
    @main_items   = @meal_plan.meal_items.where(genre: :main).includes(:my_menu)
    @side_items   = @meal_plan.meal_items.where(genre: :side).includes(:my_menu)
    @soup_items   = @meal_plan.meal_items.where(genre: :soup).includes(:my_menu)
    @staple_items = @meal_plan.meal_items.where(genre: :staple).includes(:my_menu)
    @other_items  = @meal_plan.meal_items.where(genre: :other).includes(:my_menu)
  end

  def create
    @meal_plan = current_user.meal_plans.new(meal_plan_params)

    if @meal_plan.save
      params[:meal_items]&.each do |item|
        @meal_plan.meal_items.create!(
          my_menu_id: item[:my_menu_id],
          genre: MyMenu.find(item[:my_menu_id]).genre
        )
      end

      redirect_to @meal_plan, notice: "献立を作成しました"
    else
      render :new
    end
  end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(:date, my_menu_ids: [])
  end
end
