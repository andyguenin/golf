class ScraperRunner
  @queue = :scraper
  
  def self.perform()
   # a = Scraper.last
  #  unless a.nil?
  #    pid = fork do
   #     pjs = Rails.root.join("etc", "golf_scraper.js")
    #    exec("phantomjs #{pjs} #{a.url} #{post_to}")
    #  end
    #  Process.wait(pid)   
    #end
    puts 'a'
    sleep(5.0)
    puts 'b'
#    Resque.
  end  
end