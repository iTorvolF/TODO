module Admin
  class ApplicationController < ApplicationController
    before_action :authenticate_user!
    layout 'layouts/admin/application'
  end
end