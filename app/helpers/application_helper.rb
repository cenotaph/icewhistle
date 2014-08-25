# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # include ReCaptcha::ViewHelper
  


  def blog_post(url, key)
    # require 'rss/2.0'
    # require 'rss'
    # require 'open-uri'
    out = Array.new
    now = Time.now.to_i
    cached = Cash.where(:source => key).visible
    cached_first = cached.first unless cached.empty?
    if cached.empty? 

      # begin
        feed = Feedzirra::Feed.fetch_and_parse(url)
        feed.entries.each_with_index do |item, i|
          if ++i < 6  
            if key == 'bookmarks'
              if strip_tags(item.content).blank?
                link_url = item.url
              else
                link_url = strip_tags(item.content)
              end

            else
              link_url = item.url
            end
            link_url = link_url.gsub(/^Original Page:\s*/, '').gsub('Shared from Pocket', '')
            if key == 'blindness'
              if link_url =~ /icewhistle\.com\/posts\/image/
                riu = Hpricot.parse(Net::HTTP.get(URI(link_url))).search('img').first['src'].gsub(/\/bigger\//, '/') rescue nil
              end
            end
            if key == 'ptarmigan'
              if item.title =~ /^Event\:/
                riu = Hpricot.parse(item.summary).search('img').first['src']
              end
            end
            if key == 'pixelache'
              next unless item.categories.include?('News')
              riu = Hpricot.parse(Net::HTTP.get(URI(link_url))).search('img.wp-post-image').first['src'] rescue nil
            end
            Cash.create(:source => key, :title => item.title.blank? ? 'untitled' : item.title.gsub(/\\\'/, '\'').gsub(/^Event\:\s+/, ''), :remote_image_url => riu.nil? ? false : riu,
                      :link_url => link_url, :order => item.published.to_i, :content => Time.now.to_i)
            out.push([item.title.blank? ? 'untitled' : item.title.gsub(/\\\'/, '\''), link_url.sub(/\.rss$/, '')])
          end       
        end
      # rescue 
      #   out =  ['Sorry, can\'t connect right now!', url]
      # end
    elsif now - cached_first.updated_at.to_i < 1000
      
      cached.sort_by{|x| x.order}.each do |cached|
        out.push([cached.title, cached.link_url])
      end
    else
      
      # kill the old ones
      cached.map{|x| x.destroy unless x.image? }
      urlmatch = Regexp.new('(http|https|ftp)\://[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+&amp;%\$#\=~])*')
      begin
        open(url) do |http|
          feed = Feedzirra::Feed.fetch_and_parse(url)
          feed.entries.each_with_index do |item, i|
            if ++i < 6
              if key == 'bookmarks'
                if strip_tags(item.content).blank?
                  link_url = item.url
                else
                  link_url = strip_tags(item.content)
                end

              else
                link_url = item.url
              end
              link_url = link_url.gsub(/^Original Page:\s*/, '').gsub('Shared from Pocket', '')
              if key == 'blindness'
                if link_url =~ /icewhistle\.com\/posts\/image/
                  riu = Hpricot.parse(Net::HTTP.get(URI(link_url))).search('img').first['src'].gsub(/\/bigger\//, '/') rescue nil
                end
              end
              if key == 'ptarmigan'
                if item.title =~ /^Event\:/
                  riu = Hpricot.parse(item.summary).search('img').first['src']
                end
              end
              if key == 'pixelache'
                next unless item.categories.include?('News')
                riu = Hpricot.parse(Net::HTTP.get(URI(link_url))).search('img.wp-post-image').first['src'] rescue nil
              end
 
              # Cash.create(:source => key, :title => item.title.blank? ? 'untitled' : item.title.gsub(/\\\'/, '\''),                        :link_url => link, :order => i, :content => Time.now.to_i)
              next unless Cash.find_by(:link_url => link_url).nil?
              Cash.create(:source => key, :title => item.title.blank? ? 'untitled' : item.title.gsub(/\\\'/, '\'').gsub(/^Event\:\s+/, ''), :remote_image_url => riu.nil? ? false : riu,
                        :link_url => link_url, :order => item.published.to_i, :content => Time.now.to_i)
              out.push([item.title.blank? ? 'untitled' : item.title.gsub(/\\\'/, '\''), link_url.sub(/\.rss$/, '')])
            
            end       
          end
        end
      rescue 
        out =  ['Sorry, can\'t connect right now', url]
      end  
    end

    return out
  end
  
  def comment_glimpse(post)
    if post.extended.blank?
      if post.comments.blank?
        return link_to('See standalone post....', post) 
      else
        return link_to(post.comments.size.to_s + ' comments.  See comments ...', post)
      end
    else
      return link_to('This is only the beginning.  Click here to read the full post...', post)
    end
  end

  def delicious_bookmarks(username, pw)
    
    @delicious = ""
    http = ""
    resp = ""
    require 'net/https'
    require "rexml/document"
    begin
      http = Net::HTTP.new('api.del.icio.us', 443)
      http.use_ssl = true
      http.start do |http|
      request = Net::HTTP::Get.new('/v1/posts/recent?&count=7')
      request.basic_auth username, pw
      response = http.request(request)
      response.value
      resp = response.body
      doc = REXML::Document.new(resp)
      doc.elements.each("*/post") { |element| @delicious += "<span class=\"side_title\">  <a href=\"" + element.attributes["href"] + "\">" + element.attributes["description"] + "</a></span><br>" + (element.attributes["extended"].blank? ? "" : "<div class=\"extended\">" + element.attributes["extended"] + "</div><br />") }
     end
    rescue SocketError
      @delicious = "Host unavailable"
    rescue REXML::ParseException => e
     @delicious = "error parsing XML "  + e.to_s
    rescue ActionView::TemplateError 
     @delicious = "Delicious error - wrong password?"
   end
    return @delicious
    

  end
  
  def evernote
    blog_post('http://icewhistle.postach.io/feed', 'bookmarks')
  end

  def format_tags(post)
    if post.tag_list.blank?
      ""
    else
      "<h4>Tags:</h4> " + post.tag_list.collect{|x| link_to(x, {:controller => 'tags', :action => 'show', :id => x})}.join(', ')
    end
  end
  
  def generate_popup(link)
    return link_to(image_tag('/images/icons/' + link['imagefilename'] + '.png'), link.url, { :onmouseout => "document.getElementById('links_menu').style.display = 'none'; document.getElementById('link_title').innerHTML = ''; document.getElementById('link_description').innerHTML =''", :onmouseover => "document.getElementById('links_menu').style.display = 'block';document.getElementById('link_title').innerHTML ='" + link.name + "'; document.getElementById('link_description').innerHTML ='" + link.description + "'" })
  end
  
  def recent_posts
    returned = ''
    Post.find(:all, :order => 'created_at DESC', :limit => 5).each do |post|
      returned +=  '<li class="sidebar_entry">  ' + link_to(post['title'], post) + '</li>'
    end
    return returned
  end
  
  def recent_crumbles
    returned = ''
    Crumble.find(:all, :order => 'created_at DESC', :limit => 5).each do |post|
      returned +=  '<li class="sidebar_entry"> ' + link_to(post['title'], post) +  (post.datestamp.blank? ? '' : " [#{post.datestamp.strftime('%Y')}]") + '</li>'
    end
    return returned
  end
  
  def share_this(item)
    out = "<span class='st_sharethis' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "' displayText=''></span><span class='st_twitter' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span><span class='st_facebook' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span>"
    out += "<span class='st_reddit' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span>"
    out += "<span class='st_plusone' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span>"
    out += "<span class='st_email' st_title='" + item.name + "' st_url='http://#{request.host}" + url_for(item) + "'  displayText=''></span>"
    #out = "<span class='st_sharethis' displayText='ShareThis'></span><span class='st_twitter' displayText='Tweet'></span><span class='st_facebook' displayText='Facebook'></span><span class='st_googleplus' displayText='Google +'></span><span class='st_reddit' displayText='Reddit'></span><span class='st_email' displayText='Email'></span>"
    return out.html_safe
  end
  
  def twitter_status
    saved_tweet = Cash.where(:source => 'twitter').visible
    last_tweet = saved_tweet.first unless saved_tweet.empty?
    now = Time.now.to_i
    if saved_tweet.empty?
      begin
        regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
        twitter = Twitter::REST::Client.new do |config|
          config.consumer_key = ENV['TWITTER_KEY']
          config.consumer_secret = ENV['TWITTER_SECRET']
          config.access_token   = ENV['TWITTER_ACCESS']
          config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
        end

        twit = twitter.user_timeline("hyksos").first
        out = [twit.text.gsub( regex, '<a href="\1">\1</a>').gsub(/\@([a-zA-Z0-9_]+)/, '<a href="http://www.twitter.com/#!/\1">@\1</a>'), twit.created_at, twit.id]
      rescue 
        out =  ['Sorry, can\'t connect to Twitter right now - maybe you can <a href="http://www.twitter.com/hyksos">try</a>.', Time.now, 0]
      end
      s = Cash.new(:source => 'twitter', :content => out.first, :order => twit.created_at.to_i, :title => twit.id)
      s.save!
      return out
    elsif now - last_tweet.updated_at.to_i < 900
      return [last_tweet.content, last_tweet.order, last_tweet.title]
    else
      begin
        regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
        twitter = Twitter::REST::Client.new do |config|
          config.consumer_key = ENV['TWITTER_KEY']
          config.consumer_secret = ENV['TWITTER_SECRET']
          config.access_token   = ENV['TWITTER_ACCESS']
          config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
        end

        twit = twitter.user_timeline("hyksos").first
        out = [twit.text.gsub( regex, '<a href="\1">\1</a>').gsub(/\@([a-zA-Z0-9_]+)/, '<a href="http://www.twitter.com/#!/\1">@\1</a>'), twit.created_at, twit.id]
        if twit.id == last_tweet.title
          return out
        else
          last_tweet.content = out.first
          last_tweet.order = twit.created_at.to_i
          last_tweet.title = twit.id
          last_tweet.save!
          return out
        end
      rescue 
        return [last_tweet.content, last_tweet.order, last_tweet.title]
      end
    end
  end
  
  
end
