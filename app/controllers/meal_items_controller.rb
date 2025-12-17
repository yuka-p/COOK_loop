class MealItemsController < ApplicationController
  before_action :authenticate_user!

  def mark_as_cooked
    ids = params[:meal_item_ids]

    if ids.blank?
      redirect_to home_path, alert: "メニューを選択してください"
      return
    end

    meal_items = MealItem.where(id: ids)

    meal_items.each do |item|
      item.update!(cooked: true, cooked_at: Time.current)
      item.my_menu.update!(last_cooked_at: item.meal_plan.date)
    end

    redirect_to home_path, notice: "選択したメニューを作成完了にしました"
  end

  def remove_from_plan
    ids = params[:meal_item_ids]

    if ids.blank?
      redirect_to home_path, alert: "メニューを選択してください"
      return
    end

    MealItem.where(id: ids).destroy_all

    redirect_to home_path, notice: "選択したメニューを献立から削除しました"
  end
end
