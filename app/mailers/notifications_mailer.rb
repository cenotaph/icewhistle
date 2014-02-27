class NotificationsMailer < ActionMailer::Base
  default from: "from@example.com"
  default to: "fail@cenotaph.org"
  
  def new_message(message)
    @message = message
    mail(:subject => "Icewhistle.com contact form: #{message.subject}")
  end

end
