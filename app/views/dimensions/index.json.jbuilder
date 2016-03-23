json.array!(@dimensions) do |dimension|
  json.extract! dimension, :id, :width, :height
  json.url dimension_url(dimension, format: :json)
end
