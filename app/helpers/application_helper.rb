# frozen_string_literal: true

module ApplicationHelper
  def current_user_avatar?
    user_signed_in? && current_user.avatar.attached?
  end

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
    locale == I18n.default_locale.to_s ? 'EN' : 'RU'
  end

  def locale
    lang = session.fetch(:locale, I18n.default_locale.to_s)
    lang = I18n.default_locale.to_s unless I18n.available_locales.map(&:to_s).include? lang
    lang
  end

  def action_title(_klass, action_name)
    action_case = action_name == 'index' ? 'many' : 'accusative'

    [
      t("label.#{action_name}"),
      t("activerecord.models.user.#{action_case}")
    ].join(' ')
  end
end
