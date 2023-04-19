require 'rails_helper'

RSpec.describe 'Sheets', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/sheets/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/sheets/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/sheets/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/sheets/edit'
      expect(response).to have_http_status(:success)
    end
  end
end
