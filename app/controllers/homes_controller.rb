class HomesController < ApplicationController

  def upload
    file = params[:file]

    if file.present?
      # cria uma pasta chamada stora/emails
      folder = Rails.root.join("storage", "emails")
      FileUtils.mkdir_p(folder)

      # pega o nome do arqvuio e adiciona nessa pasta
      filepath = folder.join(file.original_filename)

      # salva o arquivo na pasta
      File.open(filepath, "wb") { |f| f.write(file.read) }

      ProcessEmailJob.perform_async(filepath.to_s)
      redirect_to process_logs_path
      else
      redirect_to root_path, alert: "Nenhum arquivo selecionado"
    end
  end

  def reprocess
    filename = params[:filename]
    filepath = Rails.root.join("storage", "emails", "#{filename}")

    if filename.present?
      ProcessEmailJob.perform_async(filepath.to_s)
      redirect_to process_logs_path
    else
      redirect_to root_path, alert: "Nenhum arquivo selecionado"
    end   
  end



  def new
  end
end
