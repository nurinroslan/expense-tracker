class MonthlyReportMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"] # Ensure this is your actual Gmail

  def monthly_report(user)
    @user = user
    @report_data = generate_report(user) # Add this to provide data

    mail(to: @user.email, subject: "Monthly Expense Report")
  end

  private

  def generate_report(user)
    expenses = user.expenses.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month)
    expenses.group(:category_id).sum(:amount) 
  end
end
