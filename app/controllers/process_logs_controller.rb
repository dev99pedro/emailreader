class ProcessLogsController < ApplicationController
     include ActionView::RecordIdentifier

  def index
    @logs = ProcessLog.all
    respond_to do | format| 
      format.html
    end
  end

end
