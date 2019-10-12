class ContactController < ApplicationController
  layout :get_layout

  def new
    @message = Message.new
     set_meta_tags title: 'Contact'
     if get_layout == 'services'
       render template: 'contact/services'
     end
  end

  def index
    @message = Message.new
    set_meta_tags title: 'Contact'
    if get_layout == 'services'
      render template: 'contact/services'
    else
      render :template => 'contact/new'
    end
  end

  def create
    begin
      @message = Message.new(params[:message])
      if @message.valid?
        if verify_recaptcha(:model => @message, :message => "You have entered an incorrect CAPTCHA.")
          NotificationsMailer.new_message(@message).deliver
          redirect_to(root_path, :notice => "Your message was successfully sent.")
        else
          render template: 'contact/new'
        end
      else
        flash.now.alert = 'Please fill all fields.'
        render :new
      end
    rescue ArgumentError
      render plain: 'Go away', status: 422
    end
  end
end
