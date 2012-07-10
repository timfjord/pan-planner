module UsersHelper
  def user_list(users, opt = {})
    separator = opt.delete(:separator) || ' '
    opt.merge!(target: '_blank')
    users.map do |u| 
      opt[:href] = "https://github.com/#{u.github_username}"
      content_tag 'a', u.name, opt 
    end.join(separator.to_s)
  end
end
