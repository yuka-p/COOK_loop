class MasterMenusController < ApplicationController
  def index
    registered_ids = current_user.my_menus.where.not(master_menu_id: nil).pluck(:master_menu_id)

    @master_menus = MasterMenu.where.not(id: registered_ids)

    @selected_menu_ids = Array(params[:menu_ids])

    @master_menus = @master_menus.where(genre: params[:genre]) if params[:genre].present?

    @master_menus = @master_menus.order(:genre)
  end
end
