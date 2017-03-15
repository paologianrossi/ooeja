json.extract! bookmark, :id, :url, :title, :notes, :created_at, :updated_at
json.url bookmark_url(bookmark, format: :json)
