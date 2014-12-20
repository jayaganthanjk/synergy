json.array!(@sprints) do |sprint|
  json.extract! sprint, :id
  json.url sprint_url(sprint, format: :json)
end
