module ApplicationHelper
  
  def title
    "The Golf Tourney#{" > " + @title unless @title.nil?}"
  end
end
