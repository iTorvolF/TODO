# frozen_string_literal: true

class AboutController < ApplicationController
  #  before_action :log_start, :log_params, :log_finish, only: :index

  def index
    session[:about_counter] ||= 0
    session[:about_counter] += 1
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end
end
