require 'rails_helper'

describe Events, type: :api do
	describe 'GET /api/events' do
		it 'return success' do
			get '/api/events'
			expect(last_response.status).to eq(200)
		end
	end
end
