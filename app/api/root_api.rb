# frozen_string_literal: true

require 'grape-swagger'
class RootApi < Grape::API
  helpers ParamsHelper, FiltersHelper
  format :json
  prefix :api

  mount Events

  add_swagger_documentation
end
