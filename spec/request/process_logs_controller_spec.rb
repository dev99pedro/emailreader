require 'rails_helper'

RSpec.describe "Process", type: :request do 
  describe "GET /process_logs" do 
    it "return sucess" do 
      get process_logs_path
      expect(response).to have_http_status(:ok)
    end
  end
end