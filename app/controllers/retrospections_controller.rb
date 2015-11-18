class RetrospectionsController < ApplicationController
  respond_to :html
  
  def create
    @retrospection = Retrospection.new(retrospection_params)
    @retrospection.ip_address = request.remote_ip

    if verify_recaptcha(:model => @retrospection, :message => "Oh! It's error with reCAPTCHA!") && @retrospection.save
      flash[:notice] = 'Your survey has been submitted. Thank you so much for your feedback!'
      redirect_to '/'
    else
      flash[:error] = 'There was an error saving your feedback form. Please try again.'
      redirect_to '/retrospections'
    end

  end
  
  def index
    user_ip = request.remote_ip
    set_meta_tags title: 'Serious Retrospection'
  end
  
  protected
  
  def retrospection_params
    params.require(:retrospection).permit(:name, :age, :episodes_attended, :episodes_watched, :best_cast, :best_guest,
    :nationality, :humour, :karaoke, :music, :intropsection, :segment_1_culture, :segment_2_dance, :segment_3_distribution,
    :segment_4_mailbag, :segment_5_mjtrivia, :segment_6_showtell, :segment_7_siivous, :segment_8_trivia, 
    :segment_9_visitortasks, :segment_10_justin, :segment_11_sigame, :additional_comments, :email)
  end
  
end