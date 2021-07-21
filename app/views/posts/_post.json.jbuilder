json.extract! post, :id, :name, :title, :content, :post_date, :created_at, :updated_at
json.url post_url(post, format: :json)
