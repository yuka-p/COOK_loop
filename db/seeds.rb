# --- 初期ジャンル ---
DEFAULT_GENRES = [ "主菜", "副菜", "汁物", "主食" ]

# --- マスターメニュー（全ユーザー共通） ---
master_menus = [
  # 主菜
  { title: "鶏の唐揚げ", genre: :main },
  { title: "豚の生姜焼き", genre: :main },
  { title: "ハンバーグ", genre: :main },
  { title: "牛すき焼き", genre: :main },
  { title: "とんかつ", genre: :main },
  { title: "豚ロースのソテー", genre: :main },
  { title: "鶏の照り焼き", genre: :main },
  { title: "餃子", genre: :main },
  { title: "チキン南蛮", genre: :main },
  { title: "魚のムニエル", genre: :main },
  { title: "魚の塩焼き", genre: :main },
  { title: "魚のフライ", genre: :main },
  { title: "魚の煮付け", genre: :main },
  { title: "魚のホイル焼き", genre: :main },
  { title: "鶏つくね", genre: :main },
  { title: "肉じゃが", genre: :main },

  # 副菜
  { title: "野菜炒め", genre: :side },
  { title: "きんぴらごぼう", genre: :side },
  { title: "たまごやき", genre: :side },
  { title: "ほうれん草の胡麻和え", genre: :side },
  { title: "ポテトサラダ", genre: :side },
  { title: "切り干し大根", genre: :side },
  { title: "なすの煮浸し", genre: :side },
  { title: "ひじき煮", genre: :side },
  { title: "サラダ", genre: :side },
  { title: "かぼちゃの煮物", genre: :side },
  { title: "白菜の浅漬け", genre: :side },
  { title: "なすの味噌炒め", genre: :side },
  { title: "れんこんのきんぴら", genre: :side },
  { title: "マカロニサラダ", genre: :side },
  { title: "小松菜のナムル", genre: :side },
  { title: "にんじんしりしり", genre: :side },

  # 汁物
  { title: "味噌汁", genre: :soup },
  { title: "卵スープ", genre: :soup },
  { title: "わかめスープ", genre: :soup },
  { title: "ポタージュスープ", genre: :soup },
  { title: "豚汁", genre: :soup },
  { title: "お吸い物", genre: :soup },
  { title: "ミネストローネ", genre: :soup },
  { title: "クラムチャウダー", genre: :soup },
  { title: "春雨スープ", genre: :soup },
  { title: "豆乳スープ", genre: :soup },

  # 主食
  { title: "うどん", genre: :staple },
  { title: "そば", genre: :staple },
  { title: "パスタ", genre: :staple },
  { title: "ピラフ", genre: :staple },
  { title: "炊き込みご飯", genre: :staple },
  { title: "お好み焼き", genre: :staple },
  { title: "チャーハン", genre: :staple },
  { title: "カレーライス", genre: :staple },
  { title: "焼きそば", genre: :staple }
]

  master_menus.each do |menu|
  MasterMenu.create!(
    title: menu[:title],
    genre: MasterMenu.genres[menu[:genre]] # enumキーを integer に変換
  )
  end

puts "MasterMenus created!"
