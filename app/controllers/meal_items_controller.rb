class MealItemsController < ApplicationController
  before_action :authenticate_user!

  def bulk_update
    ids = params[:meal_item_ids]
    action = params[:commit_action]

    if ids.blank?
      redirect_to home_path, alert: "メニューを選択してください"
      return
    end

    meal_items = MealItem.where(id: ids)

    case action
    when "mark_as_cooked"
      meal_items.each do |item|
        item.update!(cooked: true, cooked_at: Time.current)
        # ✅ 作成完了のときだけ最終調理日を更新
        item.my_menu.update!(last_cooked_at: today)
      end

      redirect_to home_path, notice: "選択したメニューを作成完了にしました"

    when "remove_from_plan"
      # ✅ 削除は献立から外すだけ（調理日は触らない）
      meal_items.destroy_all

      redirect_to home_path, notice: "選択したメニューを献立から削除しました"

    else
      redirect_to home_path, alert: "不正な操作です"
    end
  end
end
