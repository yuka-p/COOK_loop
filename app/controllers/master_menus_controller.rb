class MasterMenusController < ApplicationController
  def index
    # ① 現在のユーザーが MyMenu に登録している master_menu_id を取得
    registered_ids = current_user.my_menus.where.not(master_menu_id: nil).pluck(:master_menu_id)

    # ② 登録済みを除外して取得
    @master_menus = MasterMenu.where.not(id: registered_ids)

    # ③ 単一ジャンル絞り込み（params[:genre] を見る）
    if params[:genre].present?
      @master_menus = @master_menus.where(genre: params[:genre])
    end

    # ④ 並び順
    @master_menus = @master_menus.order(:genre)
  end
end
