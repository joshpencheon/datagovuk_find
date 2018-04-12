require 'rails_helper'

describe 'legacy', type: :request do
  describe 'dataset update' do
    it 'shows a page informing the user the updated dataset will be available soon' do
      get '/dataset/foo-bar', params: {}, headers: { 'HTTP_REFERER' => "http://foobar.com/dataset/edit/baz" }

      expect(response.body).to include("Changes to your datasets")
    end
  end
end
