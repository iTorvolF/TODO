# frozen_string_literal: true

class AboutController < ApplicationController
  def index
    Rails.logger.info '#########################################'
    Rails.logger.info params.inspect
    Rails.logger.info '#########################################'
  end
end
