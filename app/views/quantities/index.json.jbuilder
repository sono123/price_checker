json.array!(@quantities) do |quantity|
  json.extract! quantity, :id, :quantity
  json.url quantity_url(quantity, format: :json)
end
