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
(0..4).each do |front|
	(0..4).each do |back|
		InkColor.create(front: front, back: back)
	end
end


# Bleeds
[false, true].each do |front|
	[false, true].each do |back|
		Bleed.create(front: front, back: back)
	end
end


# Raised Inks
(0..4).each do |front|
	(0..4).each do |back|
		RaisedInk.create(front: front, back: back)
	end
end


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

Coating.create(front: "uv coating", back: "uv coating")
Coating.create(front: "uv coating", back: "none")
Coating.create(front: "none", back: "uv coating")

Coating.create(front: "dull matte", back: "dull matte")
Coating.create(front: "dull matte", back: "none")
Coating.create(front: "none", back: "dull matte")

Coating.create(front: "silk laminate", back: "silk laminate")
Coating.create(front: "silk laminate", back: "none")
Coating.create(front: "none", back: "silk laminate")

Coating.create(front: "suede laminate", back: "suede laminate")
Coating.create(front: "suede laminate", back: "none")
Coating.create(front: "none", back: "suede laminate")

Coating.create(front: "varnish", back: "varnish")
Coating.create(front: "varnish", back: "none")
Coating.create(front: "none", back: "varnish")



# Quantities
quantity_increments = [250, 500, 1000, 1500, 2000, 2500]
quantity_increments.each do |qty|
	Quantity.create(quantity: qty)
end


# Box Counts
box_increments = (1..10).to_a
box_increments.each do |qty|
	BoxCount.create(box_count: qty)
end

# Metals
Metal.create(front: "none", back: "none")

Metal.create(front: "foil stamped", back: "foil stamped")
Metal.create(front: "foil stamped", back: "none")
Metal.create(front: "none", back: "foil stamped")

Metal.create(front: "inline foil", back: "inline foil")
Metal.create(front: "inline foil", back: "none")
Metal.create(front: "none", back: "inline foil")

Metal.create(front: "metallic ink", back: "metallic ink")
Metal.create(front: "metallic ink", back: "none")
Metal.create(front: "none", back: "metallic ink")


