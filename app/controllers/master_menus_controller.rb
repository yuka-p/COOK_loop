class MasterMenusController < ApplicationController
  def index
    # 現在のユーザーが MyMenu に登録している master_menu_id を取得
    registered_ids = current_user.my_menus.pluck(:master_menu_id).compact

    # 登録済み ID を除外して、genre 順に並べる
    @master_menus = MasterMenu
                      .where.not(id: registered_ids)
                      .order(:genre)
  end
end
