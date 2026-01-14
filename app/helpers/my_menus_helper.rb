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

def genre_heading_class(genre)
    case genre
    when "staple"
      "bg-[#fad9e2]/50 text-gray-700 border-[#fad9e2]"
    when "main"
      "bg-[#edd4bf]/50 text-gray-700 border-[#edd4bf]"
    when "side"
      "bg-[#c9ded2]/50 text-gray-700 border-[#c9ded2]"
    when "soup"
      "bg-[#faf2c7]/50 text-gray-700 border-[#faf2c7]"
    else
      "bg-[#C9DFEC]/50 text-gray-700 border-[#C9DFEC]"
    end
  end
end
