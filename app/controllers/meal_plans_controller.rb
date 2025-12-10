class MealPlansController < ApplicationController
  def index
  end

  def new
    @meal_plan = MealPlan.new
    @my_menus = current_user.my_menus   # メニュー選択用
  end

  def show
  end

  def create
    @meal_plan = current_user.meal_plans.new(meal_plan_params)

    if @meal_plan.save
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
