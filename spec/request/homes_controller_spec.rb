require 'rails_helper'

RSpec.describe "Homes", type: :request do 
  describe 'POST /upload_emails' do 
    let(:file_path) {Rails.root.join("spec", "fixtures", "emails", "test_email1.eml")}
    # pega o email da pasta de testes
    let(:uploaded_file) { fixture_file_upload(file_path, "message/rfc822") }
    # simula um arquivo enviado via formulário HTML (<input type="file">)
    it "return sucess to upload" do 
      post upload_emails_path, params: {file: uploaded_file}
      # faz o post
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(process_logs_path)
    end
  end


  describe 'POST /reprocess_emails' do 
    it "return reprocess" do 
      post reprocess_emails_path, params: {filename: 'email1.eml' }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(process_logs_path)
    end
  end

end