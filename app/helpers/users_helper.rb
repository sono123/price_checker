module UsersHelper

	def gravatar_for(user, options = { size: 80, class: "gravatar" })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		class_names = options[:class]
		image_tag(gravatar_url, alt: user.name, class: "#{class_names}")
	end

end
