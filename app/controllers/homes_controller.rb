class HomesController < ApplicationController

  def upload
    file = params[:file]

    if file.present?
      # cria uma pasta chamada stora/emails
      folder = Rails.root.join("storage", "emails")
      FileUtils.mkdir_p(folder)

      # pega o nome do arqvuio e adiciona nessa pasta
      filepath = folder.join(file.original_filename)

      File.open(filepath, "wb") { |f| f.write(file.read) }

      ProcessEmailJob.perform_async(filepath.to_s)
      redirect_to process_logs_path, notice: "Arquivo enviado para processamento"
        else
      redirect_to root_path, alert: "Nenhum arquivo selecionado"
    end
  end

  # CRIAR UM BOTAO DE REPROCESSAR INDEX DE VIEWS/PROCESS LOGS, PARA REPROCESSAR OS ARQUIVOS QUE DERAM FAIL


  def new
  end
end
