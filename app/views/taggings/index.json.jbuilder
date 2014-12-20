json.array!(@taggings) do |tagging|
  json.extract! tagging, :id
  json.url tagging_url(tagging, format: :json)
end
