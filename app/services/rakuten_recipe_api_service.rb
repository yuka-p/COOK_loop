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
  all_categories = (list["result"]["large"] || []) +
                    (list["result"]["medium"] || []) +
                    (list["result"]["small"] || [])

  # 名前が一致するものを探す（完全一致に近いものを優先）
  found = all_categories.find { |c| c["categoryName"] == query } ||
          all_categories.find { |c| c["categoryName"].include?(query) }

  if found.nil?
    # 簡易的な変換マップ
    search_map = { "たまねぎ" => "玉ねぎ", "茄子" => "なす" }
    alternative = search_map[query]
    found = all_categories.find { |c| c["categoryName"].include?(alternative) } if alternative
  end

  if found
    id = found["categoryId"].to_s
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
  conn = Faraday.new(url: RANKING_URL) do |f|
    f.headers["x-api-key"] = @api_key
    f.headers["Content-Type"] = "application/json"
    f.adapter Faraday.default_adapter
  end

  response = conn.get do |req|
    req.params["applicationId"] = @application_id
    req.params["accessKey"] = @api_key
    req.params["format"] = "json"
    req.params["categoryId"] = category_id if category_id
  end

  if response.success?
    body = JSON.parse(response.body)
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
