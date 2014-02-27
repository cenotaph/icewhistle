class ContactController < ApplicationController

  def new
    @message = Message.new
  end


  def index
    @message = Message.new
    render :template => 'contact/new'
  end
  
  def create
    @message = Message.new(params[:message])
    
    if @message.valid?
      if verify_recaptcha(:model => @message, :message => "You have entered an incorrect CAPTCHA.")
        NotificationsMailer.new_message(@message).deliver
        redirect_to(root_path, :notice => "Your message was successfully sent.")
      else
        render :template => 'contact/new'
      end
    else
      flash.now.alert = "Please fill all fields."
      render :new
    end
  end

end