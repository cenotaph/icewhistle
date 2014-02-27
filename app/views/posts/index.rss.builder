# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 'icewhistle.com' 
    xml.description "Icewhistle (John W. Fail) posts"
    xml.link posts_url(:format => :rss)

    for article in @posts
      xml.item do
        xml.title article.title
        xml.description article.fulltext
        unless article.enclosure_url.blank?
          e = {:url => article.enclosure_url, :length => article.enclosure_length, :type => article.enclosure_type }
          xml.enclosure e
        end
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link post_url(article)
        xml.guid posts_url(:format => :rss)
      end
    end
  end
end

