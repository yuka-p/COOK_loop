require 'faraday'
require 'json'

class RakutenRecipeApiService
  BASE_URL = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426'

  def initialize
    @app_id = ENV['RAKUTEN_RECIPE_APP_ID']
    @access_key = ENV['RAKUTEN_ACCESS_KEY']
  end

  def fetch_category_ranking(category_id = "0")
  conn = Faraday.new(url: BASE_URL) do |faraday|
    faraday.headers['x-api-key'] = @access_key
    faraday.headers['x-rakuten-application-id'] = @app_id
    faraday.headers['Content-Type'] = 'application/json'
    
    faraday.request :url_encoded
    faraday.response :logger, Rails.logger
    faraday.adapter Faraday.default_adapter
  end

  begin
    response = conn.get do |req|
      req.params['categoryId'] = category_id
    end

    handle_response(response)
    rescue Faraday::Error => e
      Rails.logger.error "通信エラー: #{e.message}"
      { error: "楽天レシピとの通信中にエラーが発生しました。" }
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
