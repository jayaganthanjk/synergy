json.array!(@searches) do |search|
  json.extract! search, :id, :index
  json.url search_url(search, format: :json)
end
