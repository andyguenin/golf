class ScoreUpdater
  @queue = :scorequeue
  
  def self.perform(s)
    User.first.update_attribute(:name, s)
  end
end
