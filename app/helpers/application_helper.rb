#
module ApplicationHelper
  def user_links
    if logged_in?
      "#{link_to 'Log out', logout_path}
      #{link_to 'Edit', edit_user_path(current_user)}
      #{link_to 'Show All Users', users_path}"
    else
      "#{link_to 'Sign up now!', signup_path}
      #{link_to 'Login', login_path}
      #{link_to 'Show Users', users_path}"
    end
  end

  def admin_account(user)
    return image_tag('finger.jpg', width: '32', height: '32', alt: 'Freedom', class: 'admin') if user.admin?
    ""
  end

  private

  def _render_errors(model, text)
    "#{error_count(model, text)} #{error_messages(model)}".html_safe
  end

  def error_count(model, text)
    content_tag(:h2, "#{pluralize(model.errors.count, 'error')} #{text}")
  end

  def error_messages(model)
    content_tag :ul do
      model.errors.full_messages.map do |message|
        concat(content_tag(:li, message))
      end
    end
  end
end
