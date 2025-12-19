
require 'rails_helper'

RSpec.describe "BaseParser", type: :service do 
  it "initializes with email body and subject" do
    email_double = double("Mail", body: "conteúdo do email", subject: "Assunto")
    parser = BaseParser.allocate  
    parser.send(:initialize, email_double)

    body = parser.instance_variable_get(:@email)
    subject = parser.instance_variable_get(:@subject)

    expect(body).to eq("conteúdo do email".force_encoding("UTF-8"))
    expect(subject).to eq("Assunto")
  end

  it "raises NotImplementedError for dataparsed" do
  email_double = double("Mail", body: "conteúdo", subject: "assunto")
  parser = BaseParser.allocate
  parser.send(:initialize, email_double)

  expect { parser.dataparsed }.to raise_error(NotImplementedError)
  end

  it "extracts pattern from email body" do
  email_double = double("Mail", body: "Order number: 12345", subject: "Pedido")
  parser = BaseParser.allocate
  parser.send(:initialize, email_double)

  result = parser.send(:extract, /Order number: (\d+)/)
  expect(result).to eq("12345")
  end

  it "returns nil if pattern not found" do
    email_double = double("Mail", body: "No order here", subject: "Pedido")
    parser = BaseParser.allocate
    parser.send(:initialize, email_double)

    result = parser.send(:extract, /Order number: (\d+)/)
    expect(result).to be_nil
  end


end