class T
  
  def self.delete_all
    if Rails.env.development?
      Player.all.each {|p| p.delete}
      Tplayer.all.each {|p| p.delete}
      Tournament.all.each {|p| p.delete}
      Score.all.each {|p| p.delete}
      QAnswer.all.each {|p| p.delete}
      Hole.all.each {|p| p.delete}
      Pick.all.each {|p| p.delete}
      Pool.all.each {|p| p.delete}
      Course.all.each {|p| p.delete}
    end
  end
end