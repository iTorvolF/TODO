# frozen_string_literal: true

module ApplicationHelper

  def activate_title(user)
    user.active? ? 'Disactivate' : 'Activate'
  end

  def current_date
    Date.current.to_s
  end

  def list_tag(arr)
    tag.ul do
      safe_join(arr.map { |x| tag.li(x) })
    end
  end

  def language_link_name
    session[:locale] == I18n.default_locale.to_s ? 'EN' : 'RU'
  end

  def action_title(_klass, action_name)
    action_case = action_name == 'index' ? 'many' : 'accusative'

    [
      t("label.#{action_name}"),
      t("activerecord.models.user.#{action_case}")
    ].join(' ')
  end	
end
