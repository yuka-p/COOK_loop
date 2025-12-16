class MealItemsController < ApplicationController
  before_action :authenticate_user!

  def mark_as_cooked
    meal_items = MealItem.where(id: params[:meal_item_ids])

    meal_items.each do |item|
      item.update!(cooked: true, cooked_at: Time.current)
      item.my_menu.update!(last_cooked_at: item.meal_plan.date)
    end

    redirect_to home_path, notice: "選択したメニューを作成完了にしました"
  end

  def remove_from_plan
    meal_items = MealItem.where(id: params[:meal_item_ids])

    meal_items.each do |item|
      item.meal_plan.update!(date: nil)
    end

    redirect_to home_path, notice: "選択したメニューを献立から削除しました"
  end
end
