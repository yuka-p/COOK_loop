# --- 初期ジャンル ---
DEFAULT_GENRES = [ "主菜", "副菜", "汁物", "主食" ]

# --- マスターメニュー（全ユーザー共通） ---
master_menus = [
  # 主菜
  { title: "鶏の唐揚げ", genre: "主菜" },
  { title: "豚の生姜焼き", genre: "主菜" },
  { title: "ハンバーグ", genre: "主菜" },
  { title: "牛すき焼き", genre: "主菜" },
  { title: "とんかつ", genre: "主菜" },
  { title: "豚ロースのソテー", genre: "主菜" },
  { title: "鶏の照り焼き", genre: "主菜" },
  { title: "餃子", genre: "主菜" },
  { title: "チキン南蛮", genre: "主菜" },
  { title: "魚のムニエル", genre: "主菜" },
  { title: "魚の塩焼き", genre: "主菜" },
  { title: "魚のフライ", genre: "主菜" },
  { title: "魚の煮付け", genre: "主菜" },
  { title: "魚のホイル焼き", genre: "主菜" },
  { title: "鶏つくね", genre: "主菜" },
  { title: "肉じゃが", genre: "主菜" },

  # 副菜
  { title: "野菜炒め", genre: "副菜" },
  { title: "きんぴらごぼう", genre: "副菜" },
  { title: "たまごやき", genre: "副菜" },
  { title: "ほうれん草の胡麻和え", genre: "副菜" },
  { title: "ポテトサラダ", genre: "副菜" },
  { title: "切り干し大根", genre: "副菜" },
  { title: "なすの煮浸し", genre: "副菜" },
  { title: "ひじき煮", genre: "副菜" },
  { title: "サラダ", genre: "副菜" },
  { title: "かぼちゃの煮物", genre: "副菜" },
  { title: "白菜の浅漬け", genre: "副菜" },
  { title: "なすの味噌炒め", genre: "副菜" },
  { title: "れんこんのきんぴら", genre: "副菜" },
  { title: "マカロニサラダ", genre: "副菜" },
  { title: "小松菜のナムル", genre: "副菜" },
  { title: "にんじんしりしり", genre: "副菜" },

  # 汁物
  { title: "味噌汁", genre: "汁物" },
  { title: "卵スープ", genre: "汁物" },
  { title: "わかめスープ", genre: "汁物" },
  { title: "ポタージュスープ", genre: "汁物" },
  { title: "豚汁", genre: "汁物" },
  { title: "お吸い物", genre: "汁物" },
  { title: "ミネストローネ", genre: "汁物" },
  { title: "クラムチャウダー", genre: "汁物" },
  { title: "春雨スープ", genre: "汁物" },
  { title: "豆乳スープ", genre: "汁物" },

  # 主食
  { title: "うどん", genre: "主食" },
  { title: "そば", genre: "主食" },
  { title: "パスタ", genre: "主食" },
  { title: "ピラフ", genre: "主食" },
  { title: "炊き込みご飯", genre: "主食" },
  { title: "お好み焼き", genre: "主食" },
  { title: "チャーハン", genre: "主食" },
  { title: "カレーライス", genre: "主食" },
  { title: "焼きそば", genre: "主食" }
]

master_menus.each do |menu|
  MasterMenu.find_or_create_by!(title: menu[:title]) do |m|
    m.genre = menu[:genre]
  end
end

puts "MasterMenus created!"
