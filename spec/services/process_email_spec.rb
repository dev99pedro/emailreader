
require 'rails_helper'

RSpec.describe "ProcessEmail", type: :service do 

  describe "process PARSER" do 

    it "contains the correct mapping of email to parser class" do 
      expect(ProcessEmail::PARSER).to include(
        "loja@fornecedorA.com" => FornecedorAParser,
        "contato@parceiroB.com" => FornecedorBParser
      )
    end

    it "instance the email parser" do
      email = "loja@fornecedorA.com"
      parser_class = ProcessEmail::PARSER[email]

      expect(parser_class).to eq(FornecedorAParser)
    end

    it "does not include unexpected keys" do
      expect(ProcessEmail::PARSER.keys).to match_array([
        "loja@fornecedorA.com",
        "contato@parceiroB.com"
      ])
    end
  end


  describe "process" do 
    let (:email) {double(from: ['foo@foo.com'])}

    it "should read the email" do
      allow(Mail).to receive(:read).and_return(email)
      process_email = ProcessEmail.new("email.eml")
      result = process_email.process rescue nil  # só pra não quebrar se der erro
      expect(Mail).to have_received(:read)       # opcional: verificar se foi chamado
    end

   it "raises error if file is not .eml" do
    process_email = ProcessEmail.new("email.txt")
    expect { process_email.send(:validate_parser) }.to raise_error("Arquivo precisa ser .eml")
   end

    it "raises error if sender is not recognized" do
        unknown_email = double(from: ["desconhecido@x.com"])
        allow(Mail).to receive(:read).and_return(unknown_email)

        process_email = ProcessEmail.new("email.eml")

        expect { process_email.process }.to raise_error(/não é um remetente/)
    end

    it "calls the correct parser and returns parsed data" do
      email_double = double(from: ["loja@fornecedorA.com"])
      allow(Mail).to receive(:read).and_return(email_double)

      parser_instance = double("FornecedorAParser", dataparsed: { success: true })
      allow(FornecedorAParser).to receive(:new).with(email_double).and_return(parser_instance)

      process_email = ProcessEmail.new("email.eml")
      result = process_email.process

      expect(result).to eq({ success: true })
    end
    
  end

end