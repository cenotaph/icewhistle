namespace :icewhistle do
  
  desc 'migrate slugs'
  task :migrate_slugs => :environment do
    Post.all.each.each {|x| x.save(validate: false) }
    Crumble.all.each {|x| x.save(validate: false) }
  end
  
  
  desc 'migrate to s3'
  task :migrate_to_s3 => :environment do
    Post.where("image is not null").each do |pp|
      pp.remote_image_url = ("http://icewhistle.com/" + pp.image.store_dir + "/" + pp[:image]).gsub(/development\//, '').gsub(/production\//, '')
      pp.save
    end
    Crumble.all.each do |c|
      unless c.icon.blank?
        c.remote_icon_url = ("http://icewhistle.com/" + c.icon.store_dir + "/" + c[:icon]).gsub(/development\//, '').gsub(/production\//, '')
      end
      c.remote_attachment_url = ("http://icewhistle.com/" + c.attachment.store_dir + "/" + c[:attachment]).gsub(/development\//, '').gsub(/production\//, '')
      c.save
    end
    Ckeditor::Picture.all.each do |ck|
      ck.remote_data_url = ("http://icewhistle.com/" + ck.data.store_dir + "/" + ck[:data_file_name]).gsub(/development\//, '').gsub(/production\//, '')
      ck.save
    end
    Photo.all.each do |pp|
      pp.remote_filename_url = ("http://icewhistle.com/" + pp.filename.store_dir + "/" + pp[:filename]).gsub(/development\//, '').gsub(/production\//, '')
      pp.save
    end
  end
  
  desc 'Get cached content'
  task :get_cache => :environment do
    now = Time.now.to_i
    [ ['http://feeds.feedburner.com/Blindness', 'blindness'],
      ['http://ptarmigan.ee/feed.rss', 'ptarmigan'],
      ['http://www.pixelache.ac/feed/', 'pixelache'],
      ['https://zapier.com/engine/rss/783441/bookmarks/', 'bookmarks']
    ].each do |site|
      key = site.last
      cached = Cash.where(:source => key)

      feed = Feedjira::Feed.fetch_and_parse(site.first)
      unless feed.class == Fixnum
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
end