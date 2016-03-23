json.array!(@business_cards) do |business_card|
  json.extract! business_card, :id
  json.url business_card_url(business_card, format: :json)
end
