class Notifier < ActionMailer::Base
  def mail(name, message, sender)
    @from = sender
    @recipients = "fail@cenotaph.org"
    @subject = "Message from #{name} via Icewhistle contact"
    @body["message"] = message
  end

end
