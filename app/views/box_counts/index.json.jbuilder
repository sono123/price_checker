json.array!(@box_counts) do |box_count|
  json.extract! box_count, :id, :box_count
  json.url box_count_url(box_count, format: :json)
end
