class MonthlyReportJob < ApplicationJob
  queue_as :mailers # Change from :reports to :mailers

  def perform
    User.find_each do |user|
      MonthlyReportMailer.send_report(user).deliver_later
    end
  end
end
