class ProcessEmailJob
  include Sidekiq::Job

  def perform(email)
    filename = File.basename(email.to_s).downcase
    
    # Cria o log com status pendente PRIMEIRO
    log = ProcessLog.create(
      status: "pending",
      filename: filename,
      error: nil,
      extracteddata: nil
    )

    begin
      # Aguarda um pouco
      sleep 2
      
      # Processa o email
      result = ProcessEmail.new(email).process
      
      if result.nil?
        log.update(status: "failed", error: "Nenhum dado extraído do arquivo")
      else
        # Cria o customer
        customer = Customer.new(result)
        if customer.save
          log.update(status: "completed", extracteddata: result)
        else
          log.update(status: "failed", error: customer.errors.full_messages.join(", "))
        end
      end

    rescue => e
    
      log.update(status: "failed", error: e.message)
    ensure
      # Sempre faz broadcast
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


    Turbo::StreamsChannel.broadcast_update_to(
      "updatelogscount",
      target: "logs_stats",
      partial: "process_logs/stats",
      locals: {logs: ProcessLog.all}
    )
    
  end
end