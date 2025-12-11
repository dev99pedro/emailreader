class FornecedorBParser < BaseParser

  def initialize(email)
    super
  end

  
  def dataparsed
      data = {
      name: extract_name,
      phone: extract(/Telefone:\s*([^\r\n]*)/i),
      email:extract_email,
      code: extract_code
    }
    
  end


  
  def extract_name
    extract(/Cliente:\s*(.+)/i) ||
    extract(/Nome do cliente:\s*(.+)/i) ||
    extract(/Nome:\s*(.+)/i) 
  end

  def extract_email
    extract(/E-mail:\s*([^\r\n]*)/i) ||
    extract(/Email:\s*([^\r\n]*)/i) 
  end

  
  def extract_code
    extract(/Produto de interesse:\s*(.+)/i) ||
    extract(/Produto:\s*(.+)/i) ||
    extract(/código\s+(\S+)/i)
  end

end