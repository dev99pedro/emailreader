class ProcessEmailJob
  include Sidekiq::Job

  def perform(email)
    filename = File.basename(email.to_s).downcase
    log = ProcessLog.create(
      status: "in_progress",
      filename: filename,
      error: nil,
      extracteddata: nil
      )

      
    sleep 5
    begin
      result = ProcessEmail.new(email).process
      customer = Customer.new(result)
            
      if customer.save
        log.update(status: "sucess", extracteddata: result)
      else
        log.update(status: "failed", error: "Telefone ou email devem ser preenchidos")
      end

      rescue => e
        log.update(status: "failed", error: "Não foi possível ler o arquivo")

      ensure
         broadcast_logs(log)
    end
  end


  def broadcast_logs(log)
    Turbo::StreamsChannel.broadcast_replace_to(
      "updatelogs",
      target: "logs_#{log.id}", 
      partial: "shared/logs",
      locals: { log: log }
    )
  end



end

#É POR CAUSA DESSES UPDATES AQUI