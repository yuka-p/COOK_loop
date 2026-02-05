module MyMenusHelper
  def genre_border_class(menu)
    case menu.genre
    when "staple"
      "border-[#fad9e2]"
    when "main"
      "border-[#ffcfa8]"
    when "side"
      "border-[#c9ded2]"
    when "soup"
      "border-[#faf2c7]"
    else
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

  def genre_button_class(genre)
    case genre
    when "staple"
      "bg-[#fabdc3]/40 text-gray-700 border border-[#fabdc3] hover:bg-[#fabdc3]/60"
    when "main"
      "bg-[#ffab66]/40 text-gray-700 border border-[#ffab66] hover:bg-[#ffab66]/60"
    when "side"
      "bg-[#8fd1a9]/40 text-gray-700 border border-[#8fd1a9] hover:bg-[#8fd1a9]/60"
    when "soup"
      "bg-[#f5e68e]/40 text-gray-700 border border-[#f5e68e] hover:bg-[#f5e68e]/60"
    else
      "bg-[#96c2d9]/40 text-gray-700 border border-[#96c2d9] hover:bg-[#96c2d9]/60"
    end
  end

  def genre_card_border_color(menu)
    case menu.genre
    when "main"
      "#f2b973"
    when "side"
      "#8cc79b"
    when "soup"
      "#e3d780"
    when "staple"
      "#e09ca7"
    else
      "#82bfbf"
    end
  end
end
