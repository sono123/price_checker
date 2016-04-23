module StaticPagesHelper

	def print_methods
		print_methods = @print_methods.map{ |m| [multi_capitalize(m.print_method), m.id] }
		print_methods.each { |arr| arr[0].sub!("Cmyk", "CMYK")  }
		print_methods.unshift(["Select", 0])
	end

	def ink_colors
		ink_colors = @ink_colors.map { |i| [i.front.to_s + "/" + i.back.to_s, i.id] }
		ink_colors.unshift(["Select", 0])
	end

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

	def raised_inks
		raised_inks = @raised_inks.map { |i| [i.front.to_s + "/" + i.back.to_s, i.id] }
		raised_inks[0] = ["None", 1]
		raised_inks
	end

	def trim(num)
		int = num.to_i
		flot = num
		int == flot ? int : flot
	end

	def dimensions
		@dimensions.map do |i|
			["#{trim(i.height).to_s} / #{trim(i.width).to_s}", i.id]
		end
	end

	def paper_types
		paper_types = @paper_types.map { |i| [multi_capitalize(i.name) + " / " + multi_capitalize(i.color) + " / " + i.thickness.to_s + "lb", i.id] }
		paper_types.unshift(["Select", 0])
	end

	def coatings
		coatings = @coatings.map { |i| [multi_capitalize(i.front) + " / " + multi_capitalize(i.back), i.id] }
		coatings[0] = ["None", 1]
		coatings
	end

	def quantities
		quantities = @quantities.map { |i| [i.quantity, i.id] }
		quantities.unshift(["Select", 0])
	end

	def box_counts
		box_counts = @box_counts.map { |i| [i.box_count, i.id] }
		box_counts.unshift(["Select", 0])
	end

	def metals
		metals = @metals.map { |i| [multi_capitalize(i.front) + " / " + multi_capitalize(i.back), i.id] }
		metals[0] = ["None", 1]
		metals
	end

	def overhead
		if @price.to_i < 120
			"55"
		elsif @price.to_i < 250
			"75"
		else
			"105"
		end
	end

	def multi_capitalize(string)
		caps = string.split.map(&:capitalize).join(' ').sub("Cmyk", "CMYK").gsub("Uv", "UV")
	end

	def margin
		@margin = @price.to_i - (@cost.to_i + overhead.to_i)
		@margin.to_s
	end

	def similar_products(arr_string)
		if arr_string
			arr_string.slice!(0)
			arr_string.chop!

			if arr_string.length > 1
				arr = arr_string.split(",").map(&:to_i)
			else
				arr = [arr_string.to_i]
			end

			html_string = ""
			
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
		end
	end

end

















