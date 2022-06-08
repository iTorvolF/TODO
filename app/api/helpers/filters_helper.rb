# frozen_string_literal: true

module FiltersHelper
  extend Grape::API::Helpers

  def all?
    ActiveRecord::Type::Boolean.new.cast(params[:all])
  end

  def event_scope
    all? ? Event.all : Event.where(done: false)
  end
end
