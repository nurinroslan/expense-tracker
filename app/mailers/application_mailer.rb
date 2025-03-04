class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_USERNAME"] || "nurinizzati.roslan@gmail.com" # Set your Gmail
  layout "mailer"
end
