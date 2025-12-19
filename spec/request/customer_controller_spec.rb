require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  describe 'GET /customers' do
    it 'return status 200' do
      get customers_path
      expect(response).to have_http_status(:ok)
    end
  end
end