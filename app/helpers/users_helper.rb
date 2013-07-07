module UsersHelper
  def gravatar_for(user, options = {class: 'gravatar', size: 80})
    gravatar_image_tag(user.email.downcase,
                       alt: user.name,
                       class: options.delete(:class),
                       gravatar: options)
  end
end
