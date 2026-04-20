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

  def fetch_ranking(category_id = nil)
    conn = Faraday.new(url: RANKING_URL)
    response = conn.get do |req|
      req.params["applicationId"] = @application_id
      req.params["format"] = "json"
      req.params["categoryId"] = category_id if category_id
      req.params["accessKey"] = @api_key
    end

    if response.success?
      JSON.parse(response.body)["result"]
    else
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
