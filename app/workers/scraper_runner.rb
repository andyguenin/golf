class ScraperRunner
  @queue = :scraper
  
  def self.perform(j)
    pid = fork do
      pjs = Rails.root.join("etc", "golf_scraper.js")
      exec("phantomjs #{pjs}")
    end
    Process.wait(pid)   

  end  
end