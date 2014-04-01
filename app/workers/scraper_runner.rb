class ScraperRunner
  @queue = :scraper
  
  def self.perform
   a = Scraper.last
    if not a.nil? and not a.pause
      a.update_attribute(:running, true)
      pid = fork do
        pjs = Rails.root.join("etc", "golf_scraper.js")
        exec("phantomjs #{pjs} #{a.url}")
      end
      Process.wait(pid)
      a.update_attributes({:last_run => Time.now, :running => false})
      a.reload
    end
  end  
end