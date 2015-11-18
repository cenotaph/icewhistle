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
    @existing = Retrospection.where(ip_address: user_ip)
    # unless @existing.empty?
    #   if @existing.map{|x| x.created_at.to_date }.include?(Time.now.to_date)
    #     @already_in_db = 1
    #   end
    #
    # end
    set_meta_tags title: 'Serious Retrospection', canonical: 'http://johnw.fail/retrospections',
                  og: {image: 'http://icewhistle.com/assets/si_box.jpg', 
                        title: 'Serious Retrospection', type: 'website',
                         url:'http://johnw.fail/retrospections'
                      }, 
                  twitter: {card: 'summary', site: '@hyksos'}
  end
  
  protected
  
  def retrospection_params
    params.require(:retrospection).permit(:name, :age, :episodes_attended, :episodes_watched, :best_cast, :best_guest,
    :nationality, :humour, :karaoke, :music, :introspection, :segment_1_culture, :segment_2_dance, :segment_3_distribution,
    :segment_4_mailbag, :segment_5_mjtrivia, :segment_6_showtell, :segment_7_siivous, :segment_8_trivia, 
    :segment_9_visitortasks, :segment_10_justin, :segment_11_sigame, :additional_comments, :email)
  end
  
end