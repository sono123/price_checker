module UsersHelper

	def gravatar_for(user, options = { size: 80, class: "gravatar" })
		# The gravatar website uses a hashed email to identify the user.
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		# Default size is specified in the args.
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		class_names = options[:class]
		# Default class is .gravatar, but you can add more on the method call.
		image_tag(gravatar_url, alt: user.name, class: "#{class_names}")
		# The method returns the HTML for an image_tag, fully formatted with dimensions and class attributes.
	end

end
