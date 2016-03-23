json.array!(@metals) do |metal|
  json.extract! metal, :id, :front, :back
  json.url metal_url(metal, format: :json)
end
