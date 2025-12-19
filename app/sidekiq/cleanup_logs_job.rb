class CleanupLogsJob 
  include Sidekiq::Worker 

  def perform
    deleted = ProcessLog.where("created_at < ? ", 30.days.ago).delete_all
  end

end