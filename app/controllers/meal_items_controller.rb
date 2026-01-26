class MealItemsController < ApplicationController
  before_action :authenticate_user!

  def bulk_update
    ids = params[:meal_item_ids]
    action = params[:commit_action]

    if ids.blank?
      redirect_to home_path, alert: "メニューを選択してください"
      return
    end

    meal_items = MealItem.includes(:my_menu).where(id: ids)

    case action
    when "mark_as_cooked"
      ActiveRecord::Base.transaction do
        now = Time.current
        today = Date.current

        meal_items.update_all(cooked: true, cooked_at: now)

        MyMenu.where(id: meal_items.pluck(:my_menu_id))
              .update_all(last_cooked_at: Date.current)
      end

      redirect_to home_path, notice: "選択したメニューを作成完了にしました"

    when "remove_from_plan"
      meal_items.destroy_all

      redirect_to home_path, notice: "選択したメニューを献立から削除しました"

    else
      redirect_to home_path, alert: "不正な操作です"
    end
  end
end
