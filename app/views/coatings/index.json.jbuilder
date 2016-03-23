json.array!(@coatings) do |coating|
  json.extract! coating, :id, :front, :back
  json.url coating_url(coating, format: :json)
end
