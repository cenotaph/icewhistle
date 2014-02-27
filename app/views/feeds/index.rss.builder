# index.rss.builder
xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Icewhistle aggregate feed"
    xml.description "Content from "
    xml.link 'http://icewhistle.com/feeds.rss'

    for article in @posts.compact
      xml.item do
        xml.title article['title'].blank? ? 'untitled' : article['title'] 
        unless article['enclosure'].blank? 
          xml.enclosure article['enclosure']
        end
        xml.description article['description']
        xml.pubDate article['pubDate'] #.to_s(:rfc822)
        xml.link article['link']
        xml.guid article['link']
      end
    end
  end
end

