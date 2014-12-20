json.array!(@timelogs) do |timelog|
  json.extract! timelog, :id
  json.url timelog_url(timelog, format: :json)
end
