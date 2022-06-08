# frozen_string_literal: true

class RootApi < Grape::API
  helpers ParamsHelper, FiltersHelper
  format :json
  prefix :api

  mount Events
end
