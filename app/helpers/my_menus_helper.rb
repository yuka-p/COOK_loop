module MyMenusHelper
  def genre_border_class(menu)
    case menu.genre
    when "staple" # 主食
      "border-[#fad9e2]"
    when "main"   # 主菜
      "border-[#edd4bf]"
    when "side"   # 副菜
      "border-[#c9ded2]"
    when "soup"   # 汁物
      "border-[#faf2c7]"
    else         # その他
      "border-[#C9DFEC]"
    end
  end
end
