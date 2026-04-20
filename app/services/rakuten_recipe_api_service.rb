require "faraday"
require "json"

class RakutenRecipeApiService
  BASE_URL = "https://openapi.rakuten.co.jp/recipems/api/Recipe/CategoryList/20170426"
  RANKING_URL = "https://openapi.rakuten.co.jp/recipems/api/Recipe/CategoryRanking/20170426"

  def initialize
    @application_id = ENV["RAKUTEN_API_KEY"]
    @api_key = ENV["RAKUTEN_ACCESS_KEY"]
  end

  def fetch_category_list
    conn = Faraday.new(url: BASE_URL) do |faraday|
      faraday.headers["x-api-key"] = @api_key
      faraday.headers["Content-Type"] = "application/json"

      faraday.request :url_encoded
      faraday.response :logger, Rails.logger
      faraday.adapter Faraday.default_adapter
    end

    begin
      response = conn.get do |req|
        req.params["format"] = "json"
        req.params["applicationId"] = @application_id
        req.params["accessKey"] = @api_key
      end

      handle_response(response)

    rescue Faraday::Error => e
      Rails.logger.error "通信エラー: #{e.message}"
      { error: "楽天レシピとの通信中にエラーが発生しました。" }
    end
  end

def find_category_id_by_query(query)
  list = fetch_category_list
  return nil if list.nil? || list["result"].nil?

  # 大・中・小の全カテゴリを一つのフラットな配列にまとめる
  # これにより、どの階層に「たまねぎ」があっても見逃さなくなります
  all_categories = (list["result"]["large"] || []) +
                    (list["result"]["medium"] || []) +
                    (list["result"]["small"] || [])

  # 名前が一致するものを探す（完全一致に近いものを優先）
  found = all_categories.find { |c| c["categoryName"] == query } ||
          all_categories.find { |c| c["categoryName"].include?(query) }

  if found
    id = found["categoryId"].to_s

    # 【ここが重要】中・小カテゴリで親IDが必要な場合の補正
    # categoryUrlの末尾の数字が正しいランキング用IDになっていることが多いです
    if found["parentCategoryId"].present? && !id.include?("-")
      id = "#{found['parentCategoryId']}-#{id}"
    end

    Rails.logger.info "★★★ カテゴリ特定成功: #{found['categoryName']} (ID: #{id}) ★★★"
    id
  else
    Rails.logger.info "★★★ カテゴリが見つかりませんでした: #{query} ★★★"
    nil
  end
end

def fetch_ranking(category_id = nil)
  # ランキング用の接続機を作成
  conn = Faraday.new(url: RANKING_URL) do |f|
    f.headers["x-api-key"] = @api_key
    f.headers["Content-Type"] = "application/json"
    f.adapter Faraday.default_adapter
  end

  response = conn.get do |req|
    req.params["applicationId"] = @application_id
    req.params["accessKey"] = @api_key # 一念のためパラメータにも含める
    req.params["format"] = "json"
    req.params["categoryId"] = category_id if category_id
  end

  if response.success?
    body = JSON.parse(response.body)
    # 楽天のレスポンスは {"result": [...]} という形なので、resultの中身を返す
    body["result"] || []
  else
    Rails.logger.error "ランキング取得失敗: #{response.status} #{response.body}"
    []
  end
end

  private

  def handle_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      Rails.logger.error "APIリクエスト失敗: ステータス #{response.status}, 本文: #{response.body}"
      { error: "楽天レシピからの応答エラー (ステータス: #{response.status})" }
    end
  rescue JSON::ParserError
    { error: "JSON形式の解析に失敗しました。" }
  end
end
