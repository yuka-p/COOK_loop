module MyMenusHelper
  def genre_border_class(menu)
    case menu.genre
    when "staple" # 主食
      "border-[#edbfbf]"
    when "main"   # 主菜
      "border-[#FFD4B1]"
    when "side"   # 副菜
      "border-[#b0d4bf]"
    when "soup"   # 汁物
      "border-[#F2E5B6]"
    else         # その他
      "border-[#C9DFEC]"
    end
  end
end
