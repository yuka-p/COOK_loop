module MyMenusHelper
  def genre_border_class(menu)
    case menu.genre
    when "staple" # 主食
      "border-[#fad9e2]"
    when "main"   # 主菜
      "border-[#ffcfa8]"
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
      "bg-[#fabdc3]/40 text-gray-700 border-[#fabdc3]"
    when "main"
      "bg-[#ffab66]/40 text-gray-700 border-[#ffab66]"
    when "side"
      "bg-[#8fd1a9]/40 text-gray-700 border-[#8fd1a9]"
    when "soup"
      "bg-[#f5e68e]/40 text-gray-700 border-[#f5e68e]"
    else
      "bg-[#96c2d9]/40 text-gray-700 border-[#96c2d9]"
    end
  end
end
