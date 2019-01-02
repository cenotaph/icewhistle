class NotificationsMailer < ActionMailer::Base
  default from: "john@cenotaph.org"
  default to: "john@cenotaph.org"
  
  def new_message(message)
    @message = message
    mail(:subject => "Icewhistle.com contact form: #{message.subject}")
  end

  def registered_event(event, recipient)
    @event = event
    @recipient = recipient
    mail(subject: 'You have registered for #{event.name')
  end
end
