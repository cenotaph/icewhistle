class FeedsController < ApplicationController



  def index
    require 'rss/2.0'
    require 'open-uri'
    @posts = []
    feeds = [ 'http://blindness.icewhistle.com/rss/', 'http://slothrops.ee/podcasts.rss', 'http://icewhistle.com/crumbles.rss', 'http://icewhistle.com/posts.rss'] #, 'http://www.cenotaph.org/?feed=rss2', 'http://www.sharksandpfennigs.co.uk/?feed=rss2']
    cached = Cash.where(:source => 'aggregate')

    feeds.each do |url|
      begin
        open(url) do |http|
          response = http.read
          rss = RSS::Parser.parse(response, false)
          rss.items.each do |item|
            thisitem = Hash.new
            #thisitem['channel'] = item.title
            #  logger.warn("channel is " + rss.channel.title)
            thisitem['title'] =  item.title
            thisitem['description'] = item.description
            unless item.enclosure.nil?
              thisitem['enclosure'] = item.enclosure
            end
            thisitem['link'] = item.link
            item.guid.nil? ? thisitem['guid'] = 0 : thisitem['guid'] = item.guid.content
            if (item.date.nil?)
              thisitem['pubDate'] = 0
            else
              thisitem['pubDate'] = item.date
            end
            @posts << thisitem
            if nilcache == true
              Cache.create(:source => 'aggregate', :title => item.title.blank? ? 'untitled' : item.title.gsub(/\\\'/, '\''),
                        :link_url => item.link.sub(/\.rss$/, ''), :order => Time.now.to_i, :content => item.description)
            end
          end
        end
      rescue 
        nil
      end

    end
    @posts.sort! {|a,b| a['pubDate'] <=> b['pubDate']}
    @posts.reverse!
    @posts = @posts.values_at(0..24)
  end
    
    
  
end
