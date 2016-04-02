# USER SEEDS

User.create!(name: "Steve Ono",
						 email: "steveono@gmail.com",
						 password:              "foobar",
						 password_confirmation: "foobar",
						 admin: true, 
						 activated: true,
						 activated_at: Time.zone.now)

99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name: name,
							 email: email,
							 password:              password,
							 password_confirmation: password,
							 activated: true,
							 activated_at: Time.zone.now)
end



# PRODUCT RELATED SEEDS

# Print Methods
print_methods = ["pantone offset", "cmyk offset", "letterpress", "digital"]
print_methods.each do |name|
	PrintMethod.create(print_method: name)
end


# Ink Colors
InkColor.create(front: 1, back: 0)
InkColor.create(front: 2, back: 0)
InkColor.create(front: 3, back: 0)
InkColor.create(front: 4, back: 0)
InkColor.create(front: 1, back: 1)
InkColor.create(front: 2, back: 1)
InkColor.create(front: 3, back: 1)
InkColor.create(front: 4, back: 1)
InkColor.create(front: 2, back: 2)
InkColor.create(front: 3, back: 2)
InkColor.create(front: 4, back: 2)
InkColor.create(front: 3, back: 3)
InkColor.create(front: 4, back: 3)
InkColor.create(front: 4, back: 4)




# Bleeds
Bleed.create(front: false, back: false)
Bleed.create(front: true, back: false)
Bleed.create(front: false, back: true)
Bleed.create(front: true, back: true)


# Raised Inks
RaisedInk.create(front: 0, back: 0)
RaisedInk.create(front: 1, back: 0)
RaisedInk.create(front: 2, back: 0)
RaisedInk.create(front: 3, back: 0)
RaisedInk.create(front: 4, back: 0)
RaisedInk.create(front: 1, back: 1)
RaisedInk.create(front: 2, back: 1)
RaisedInk.create(front: 3, back: 1)
RaisedInk.create(front: 4, back: 1)
RaisedInk.create(front: 2, back: 2)
RaisedInk.create(front: 3, back: 2)
RaisedInk.create(front: 4, back: 2)
RaisedInk.create(front: 3, back: 3)
RaisedInk.create(front: 4, back: 3)
RaisedInk.create(front: 4, back: 4)


# Dimensions
Dimension.create(width: 3.5, height: 2)
Dimension.create(width: 2.5, height: 2.5)
Dimension.create(width: 6, height: 4)


# Paper Types
PaperType.create(brand: "neenah", name: "classic crest", color: "solar white", thickness: 130)
PaperType.create(brand: "neenah", name: "classic crest", color: "natural white", thickness: 130)
PaperType.create(brand: "neenah", name: "classic linen", color: "solar white", thickness: 130)
PaperType.create(brand: "mohawk", name: "strathmore", color: "ultimate white", thickness: 130)
PaperType.create(brand: "mohawk", name: "strathmore", color: "bright white", thickness: 130)
PaperType.create(brand: "mohawk", name: "strathmore", color: "natural white", thickness: 130)


# Coatings
Coating.create(front: "none", back: "none")

Coating.create(front: "uv", back: "none")
Coating.create(front: "none", back: "uv")
Coating.create(front: "uv", back: "uv")
Coating.create(front: "silk", back: "silk")
Coating.create(front: "suede", back: "suede")
Coating.create(front: "varnish", back: "none")
Coating.create(front: "none", back: "varnish")
Coating.create(front: "varnish", back: "varnish")


# Quantities
quantity_increments = [250, 500, 1000, 1500, 2000, 2500]
quantity_increments.each do |qty|
	Quantity.create(quantity: qty)
end


# Box Counts
(1..10).to_a.each do |qty|
	BoxCount.create(box_count: qty)
end

# Metals
Metal.create(front: "none", back: "none")
Metal.create(front: "foil", back: "none")
Metal.create(front: "none", back: "foil")
Metal.create(front: "foil", back: "foil")
Metal.create(front: "metallic ink", back: "none")
Metal.create(front: "none", back: "metallic ink")
Metal.create(front: "metallic ink", back: "metallic ink")








