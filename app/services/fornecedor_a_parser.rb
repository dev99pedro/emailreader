class FornecedorAParser < BaseParser

  def initialize(email)
    super
  end

    def dataparsed
    data = {
      name: extract_name,
      tel: extract(/Telefone:\s*([\(\)\d\s\-\+]+)/i),
      email: extract(/E-mail:\s*([^\s\r\n]+@[^\s\r\n]+)/i),
      code: extract_code,
      subject: extract_subject
    }

  
    if data[:email].blank? && data[:tel].blank?
      return data 
    end
    data
  end


  
  def extract_name
    extract(/Cliente:\s*(.+)/i) ||
    extract(/Nome do cliente:\s*(.+)/i) ||
    extract(/Nome:\s*(.+)/i) 
  end

  
  def extract_code
    extract(/Produto de interesse:\s*(.+)/i) ||
    extract(/Produto:\s*(.+)/i) ||
    extract(/código\s+(\S+)/i)
  end

  def extract_subject
    @subject.to_s
  end

end


