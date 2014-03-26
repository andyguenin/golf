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
      "DQ"
    when 6
      "Starting Soon"
    else
      "Unknown"
    end    
  end

  def get_thru_text(tp)
    if tp.status.nil? or tp.status <= 1
      scores = tp.scores.flatten(1).select{|s| s[0] != 0}.map{|s| s[0]}
      if scores.length%18 == 0
        if scores.length/18 == 4
          "F"
        else
          "End Round #{scores.length/18}"
        end
      else
        "#{scores.length%18}"
      end
    else
      "#{status_to_text(tp.status)}"
    end
  end

    
end
