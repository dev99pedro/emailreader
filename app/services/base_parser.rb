class BaseParser
  def initialize(email)
    @email = email.body.to_s.force_encoding("UTF-8")
    @subject = email.subject
   
  end

  def dataparsed
    raise NotImplementedError
  end

  protected 


  def extract(pattern)
    match = @email.match(pattern)
    match && match[1].strip.presence
  end

end