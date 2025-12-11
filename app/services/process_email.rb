class ProcessEmail

  

  PARSER = {
    "loja@fornecedorA.com" => FornecedorAParser,
    "contato@parceiroB.com" => FornecedorBParser
  }

  def initialize(email)
    @email = email 
    @filename = File.basename(@email.to_s).downcase
   
  end


  def process

    email  = Mail.read(@email)
    validate_parser

    parser = select_parser(email)

    unless parser 
      return "Email #{email.from.first} não é um remetente"
    end
    
    select_parser = parser.new(email)
    result = select_parser.dataparsed
 
    

  end

  private


  def validate_parser

   unless @filename.end_with?(".eml")
    raise "Arquivo precisa ser .eml"
   end


  end
  

  def select_parser(email)
    PARSER.each do | hash, value | 
      return value if email.from.first.match?(hash)
    end
    nil
  end






end