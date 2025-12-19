RSpec.describe FornecedorAParser do
  let(:email_body) do
    <<~EMAIL
      Cliente: João Silva
      Telefone: (11) 91234-5678
      E-mail: joao@email.com
      Produto: ProdutoX
    EMAIL
  end

  let(:email) { double("Mail", body: email_body, subject: "Pedido 123") }

  subject(:parser) { described_class.new(email) }

  describe "#dataparsed" do
    it "extracts all fields correctly" do
      result = parser.dataparsed
      expect(result[:name]).to eq("João Silva")
      expect(result[:tel]).to eq("(11) 91234-5678")
      expect(result[:email]).to eq("joao@email.com")
      expect(result[:code]).to eq("ProdutoX")
      expect(result[:subject]).to eq("Pedido 123")
    end

    it "returns data even if email and tel are blank" do
      blank_email = double("Mail", body: "Cliente: Maria\nProduto: ProdutoY", subject: "Pedido 456")
      parser_blank = described_class.new(blank_email)
      result = parser_blank.dataparsed

      expect(result[:name]).to eq("Maria")
      expect(result[:tel]).to be_nil
      expect(result[:email]).to be_nil
      expect(result[:code]).to eq("ProdutoY")
      expect(result[:subject]).to eq("Pedido 456")
    end
  end
end
