require 'rails_helper'

RSpec.describe 'Роут', type: :routing do
  it 'GET /events/:event_id/items соответствует items#index' do
    expect(get: '/events/1/items').to route_to('items#index', id: '1')
  end
end
