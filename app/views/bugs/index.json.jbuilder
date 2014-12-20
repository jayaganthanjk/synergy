json.array!(@bugs) do |bug|
  json.extract! bug, :id
  json.url bug_url(bug, format: :json)
end
