# frozen_string_literal: true

class Events < Grape::API
  include Grape::Kaminari
  helpers ParamsHelper, FiltersHelper

  resource :events do
    desc 'Список дел'
    params do
      use :filters
      use :pagination, per_page: 5, max_per_page: 5, offset: 0
    end

    get '/' do
      present paginate(event_scope), with: Entities::EventIndex
    end

    route_param :event_id, type: Integer do
      before do
        @event = event_scope.find params[:event_id]
      end

      desc 'Получить информацию о деле'
      params do
        use :filters
      end
      get '/' do
        present @event, with: Entities::Event
      end
    end
  end
end
