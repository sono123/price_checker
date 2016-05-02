module StaticPagesHelper

	# Returns a nested array of print methods for the select tags on the main search form.
	def print_methods
		print_methods = @print_methods.map{ |m| [multi_capitalize(m.print_method), m.id] }
		print_methods.each { |arr| arr[0].sub!("Cmyk", "CMYK")  }
		print_methods.unshift(["Select", 0])
	end

	# Returns a nested array of ink colors for the select tags on the main search form.
	def ink_colors
		ink_colors = @ink_colors.map { |i| [i.front.to_s + "/" + i.back.to_s, i.id] }
		ink_colors.unshift(["Select", 0])
	end

	# Returns a nested array of bleeds for the select tags on the main search form.
	def bleeds
		bleeds = @bleeds.map do |i|
			front = ""
			back = ""

			if i.front == true
				front << "1"
			else
				front << "0"
			end

			if i.back == true
				back << "1"
			else
				back << "0"
			end

			[front + "/" + back, i.id]
		end

		bleeds[0] = ["None", 1]
		bleeds
	end

	# Returns a nested array of raised inks for the select tags on the main search form.
	def raised_inks
		raised_inks = @raised_inks.map { |i| [i.front.to_s + "/" + i.back.to_s, i.id] }
		raised_inks[0] = ["None", 1]
		raised_inks
	end

	# Removes the decimal point and zero for whole numbers.
	def trim(num)
		int = num.to_i
		flot = num
		int == flot ? int : flot
	end

	# Returns a nested array of dimensions for the select tags on the main search form.
	def dimensions
		@dimensions.map do |i|
			["#{trim(i.height).to_s} / #{trim(i.width).to_s}", i.id]
		end
	end

	# Returns a nested array of paper types for the select tags on the main search form.
	def paper_types
		paper_types = @paper_types.map { |i| [multi_capitalize(i.name) + " / " + multi_capitalize(i.color) + " / " + i.thickness.to_s + "lb", i.id] }
		paper_types.unshift(["Select", 0])
	end

	# Returns a nested array of coatings for the select tags on the main search form.
	def coatings
		coatings = @coatings.map { |i| [multi_capitalize(i.front) + " / " + multi_capitalize(i.back), i.id] }
		coatings[0] = ["None", 1]
		coatings
	end

	# Returns a nested array of quantities for the select tags on the main search form.
	def quantities
		quantities = @quantities.map { |i| [i.quantity, i.id] }
		quantities.unshift(["Select", 0])
	end

	# Returns a nested array of box counts for the select tags on the main search form.
	def box_counts
		box_counts = @box_counts.map { |i| [i.box_count, i.id] }
		box_counts.unshift(["Select", 0])
	end

	# Returns a nested array of metals for the select tags on the main search form.
	def metals
		metals = @metals.map { |i| [multi_capitalize(i.front) + " / " + multi_capitalize(i.back), i.id] }
		metals[0] = ["None", 1]
		metals
	end

	# Returns the correct overhead based on the business card price.
	def overhead
		if @price.to_i < 120
			"55"
		elsif @price.to_i < 250
			"75"
		else
			"105"
		end
	end

	# Capitalizes strings that have multiple words. Also capitalizes certain abbreviations.
	def multi_capitalize(string)
		caps = string.split.map(&:capitalize).join(' ').sub("Cmyk", "CMYK").gsub("Uv", "UV")
	end

	# Returns the profit margin for a given business card.
	def margin
		@margin = @price.to_i - (@cost.to_i + overhead.to_i)
		@margin.to_s
	end

	# Returns a rather long string of HTML code
	def similar_products(arr_string)
		if arr_string
			arr_string.slice!(0)
			# The above code removes the opening "[" of the array.
			arr_string.chop!
			# The above code removes the closing "]" of the array.

			if arr_string.length > 1
				arr = arr_string.split(",").map(&:to_i)
				# Turns the remaining string into an array of integers. This helper method is not meant to be confused with the #similar_products instance method. This helper method is meant to be used in certain js.erb files.
			else
				arr = [arr_string.to_i]
				# This branch is for a single value array.
			end

			html_string = ""
			
			# Here is where the long HTML string is created. It is a achieved by a long series of string interpolation and concatination.
			arr.each_with_index do |id, index|
				bc = BusinessCard.find(id)
				html_string << "<div class='similar-product index' data-id='#{index + 1}'>"
				html_string << "<table class='table similar-product-table'>"
				html_string << "<tr><td class='top-td'>Print Method:</td><td class='top-td text-right'>#{multi_capitalize(bc.print_method.print_method)}</td></tr>"
				html_string << "<tr><td>Ink Colors:</td><td class='text-right'>#{bc.ink_color.front} / #{bc.ink_color.back}</td></tr>"
				html_string << "<tr><td>Bleeds:</td><td class='text-right'>#{bc.bleed.front ? 1 : 0} / #{bc.bleed.back ? 1 : 0}</td></tr>"
				html_string << "<tr><td>Raised Inks:</td><td class='text-right'>#{bc.raised_ink.front} / #{bc.raised_ink.back}</td></tr>"
				html_string << "<tr><td>Dimensions:</td><td class='text-right'>#{trim bc.dimension.width} x #{trim bc.dimension.height}</td></tr>"
				html_string << "<tr><td>Coatings:</td><td class='text-right'>#{multi_capitalize(bc.coating.front)} / #{multi_capitalize(bc.coating.back)}</td></tr>"
				html_string << "<tr><td>Quantity:</td><td class='text-right'>#{bc.quantity.quantity}</td></tr>"
				html_string << "<tr><td>Box Count:</td><td class='text-right'>#{bc.box_count.box_count}</td></tr>"
				html_string << "<tr><td>Paper Type:</td><td class='text-right'>#{multi_capitalize(bc.paper_type.name)} / #{multi_capitalize(bc.paper_type.color)} / #{bc.paper_type.thickness}</td></tr>"
				html_string << "<tr><td>Cost:</td><td class='text-right'>$#{bc.cost}</td></tr>"
				html_string << "<tr><td class='similar-price'>Price:</td><td class='text-right similar-price'>$#{bc.price}.00</td></tr>"
				html_string << "</table>"
				html_string << "</div>"
			end

			html_string.html_safe
			# Must call #html_safe on the string, otherwise it wont work.
		end
	end

end

















