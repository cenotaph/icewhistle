namespace :icewhistle do
  desc 'Get cached content'
  task :get_cache => :environment do
    now = Time.now.to_i
    [ ['http://feeds.feedburner.com/Blindness', 'blindness'],
      ['http://ptarmigan.ee/feed.rss', 'ptarmigan'],
      ['http://www.pixelache.ac/feed/', 'pixelache'],
      ['http://icewhistle.postach.io/feed', 'bookmarks']
    ].each do |site|
      key = site.last
      cached = Cash.where(:source => key)

      feed = Feedzirra::Feed.fetch_and_parse(site.first)
      feed.entries.each_with_index do |item, i|
      if ++i < 6  
        if key == 'bookmarks'
          if ActionController::Base.helpers.strip_tags(item.content).blank?
            link_url = item.url
          else
            link_url = ActionController::Base.helpers.strip_tags(item.content)
          end

        else
          link_url = item.url
        end
        link_url = link_url.gsub(/^Original Page:\s*/, '').gsub('Shared from Pocket', '')
        
        # skip if already in cache
        next unless Cash.find_by(:source => key, :link_url => link_url).nil?
        
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
        
        Cash.create(:source => key, :title => item.title.blank? ? 'untitled' : item.title.gsub(/\\\'/, '\'').gsub(/^Event\:\s+/, ''), :remote_image_url => riu.nil? ? false : riu, :link_url => link_url, :order => item.published.to_i, :content => Time.now.to_i)
      end
      end
    end
  end
end