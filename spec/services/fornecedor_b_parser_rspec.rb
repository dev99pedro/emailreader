RSpec.describe FornecedorBParser do
  let(:email_body) do
    <<~EMAIL
      Nome do cliente: Carlos Souza
      Telefone: 11987654321
      E-mail: carlos@email.com
      Produto de interesse: ProdutoB
    EMAIL
  end

  let(:email) { double("Mail", body: email_body, subject: "Ordem 789") }

  subject(:parser) { described_class.new(email) }

  describe "#dataparsed" do
    it "extracts all fields correctly" do
      result = parser.dataparsed
      expect(result[:name]).to eq("Carlos Souza")
      expect(result[:phone]).to eq("11987654321")
      expect(result[:email]).to eq("carlos@email.com")
      expect(result[:code]).to eq("ProdutoB")
    end

    it "returns nil for missing fields" do
      blank_email = double("Mail", body: "Cliente: Ana", subject: "Ordem 101")
      parser_blank = described_class.new(blank_email)
      result = parser_blank.dataparsed

      expect(result[:name]).to eq("Ana")
      expect(result[:phone]).to be_nil
      expect(result[:email]).to be_nil
      expect(result[:code]).to be_nil
    end
  end
end
