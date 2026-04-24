require "faraday"
require "json"

class RakutenRecipeApiService
  CATEGORY_URL = "https://openapi.rakuten.co.jp/recipems/api/Recipe/CategoryList/20170426"
  RANKING_URL = "https://openapi.rakuten.co.jp/recipems/api/Recipe/CategoryRanking/20170426"

  def initialize
    @application_id = ENV["RAKUTEN_API_KEY"]
    @api_key = ENV["RAKUTEN_ACCESS_KEY"]
  end

  # カテゴリ一覧（キャッシュ）
  def fetch_category_list
    Rails.cache.fetch("rakuten_category_list", expires_in: 24.hours) do
      response = connection(CATEGORY_URL).get do |req|
        req.params["format"] = "json"
        req.params["applicationId"] = @application_id
        req.params["accessKey"] = @api_key
      end
      handle_response(response)
    end
  end

  # カテゴリ検索
  def find_category_id_by_query(query)
    list = fetch_category_list
    return nil if list.nil? || list["result"].nil?

    all_categories = (list["result"]["large"] || []) +
                     (list["result"]["medium"] || []) +
                     (list["result"]["small"] || [])

    found = all_categories.find { |c| c["categoryName"] == query } ||
            all_categories.find { |c| c["categoryName"].include?(query) }

    if found.nil?
      search_map = { "たまねぎ" => "玉ねぎ", "茄子" => "なす" }
      alternative = search_map[query]
      found = all_categories.find { |c| c["categoryName"].include?(alternative) } if alternative
    end

    return nil unless found

    id_array = [
      found["largeCategoryId"],
      found["mediumCategoryId"],
      found["smallCategoryId"]
    ].map(&:to_s).reject(&:empty?)

    if id_array.empty?
      id = found["categoryId"].to_s
      id = "#{found['parentCategoryId']}-#{id}" if found["parentCategoryId"].present? && !id.include?("-")
    else
      id = id_array.uniq.join("-")
    end

    Rails.logger.info "★★★ カテゴリ特定成功: #{found['categoryName']} (ID: #{id}) ★★★"
    id
  end

  # ランキング取得
  def fetch_ranking(category_id = nil)
    retries = 0

    begin
      response = connection(RANKING_URL).get do |req|
        req.params["applicationId"] = @application_id
        req.params["accessKey"] = @api_key
        req.params["format"] = "json"
        req.params["categoryId"] = category_id if category_id
      end

      if response.status == 429 && retries < 3
        retries += 1
        Rails.logger.warn "429発生 → 1秒待機してリトライ #{retries}回目"
        sleep 1
        raise Faraday::RetriableResponse, "Rate limit exceeded"
      end

      if response.success?
        body = JSON.parse(response.body)
        body["result"] || []
      else
        Rails.logger.error "ランキング取得失敗: #{response.status} #{response.body}"
        []
      end

    rescue Faraday::Error => e
      if retries < 3
        retry
      else
        Rails.logger.error "通信失敗 (リトライ上限): #{e.message}"
        []
      end
    end
  end

  private

  def connection(url)
    Faraday.new(url: url) do |f|
      f.headers["x-api-key"] = @api_key
      f.headers["Content-Type"] = "application/json"
      f.adapter Faraday.default_adapter
    end
  end

  def handle_response(response)
    response.success? ? JSON.parse(response.body) : nil
  rescue JSON::ParserError
    nil
  end
end
