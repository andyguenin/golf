module TournamentHelper
  
  def status_to_text(t)
    case t
    when 2
      "MDF"
    when 3
      "CUT"
    when 4
      "WD"
    when 5
      "Starting Soon"
    else
      "Unknown"
    end    
  end
end
