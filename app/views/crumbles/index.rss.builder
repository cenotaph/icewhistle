# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" , :"xmlns:atom"=>"http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title 'icewhistle.com crumbles' 
    xml.description "John W. Fail miscellany"
    xml.link crumbles_url(:format => :rss)

    for article in @crumbles
      xml.item do
        xml.title article.title

        if article.category == 1
          xml.description  image_tag('http://icewhistle.com' + article.attachment.url(:medium)) + raw("<br />" + article.description)  
        elsif article.category == 2
          xml.enclosure(:url => article.attachment.url,
          :length => File.size?(article.attachment.path),
          :type => article.attachment.url =~ /m4a$/i ? "audio/x-m4a" : "audio/mpeg")
          xml.description raw(article.description), :type => "html"
        else
          if article.respond_to?('icon')
            if article.icon?
              xml.description image_tag(article.icon.url(:main)) + raw(article.description), :type => "html"
            else
              mydesc = xml.description raw(article.description), :type => "html"
            end
            
          else
            
          end
        end
        unless article.attachment_file_size.blank?
          e = {:url => 'http://icewhistle.com' + article.attachment.url, :length => article.attachment_file_size, :type => article.attachment_content_type }
          xml.enclosure e
        end
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link crumble_url(article)
        xml.guid crumble_url(article, :format => :rss)
      end
    end
  
  end
end

