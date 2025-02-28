class MonthlyReportJob
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    MonthlyReportMailer.send_monthly_report(user).deliver_now
  end
end

