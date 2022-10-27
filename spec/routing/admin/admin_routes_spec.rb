require 'rails_helper'

RSpec.describe 'Роут', type: :routing do
  it 'GET /admin соответствует admin/users#index' do
    expect(get: '/admin').to route_to('admin/users#index')
  end

  it 'GET /admin/events соответствует admin/events#index' do
    expect(get: '/admin/events').to route_to('admin/events#index')
  end

  it 'POST /admin/otchet/report соответствует admin/excel#excel' do
    expect(get: '/admin/excel#excel').to route_to('admin/excel#index')
  end
end
