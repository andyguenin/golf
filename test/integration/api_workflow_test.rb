require 'test_helper'

class ApiWorkflowTest < ActionDispatch::IntegrationTest
  partial_api = [["Hyundai Tournament of Champions","January","3","6","2014","Plantation Course at Kapalua - Kapalua, Maui, HI | Par 73 7,452 Yards"],[["4","3","4","4","5","4","4","3","5","4","3","4","4","4","5","4","4","5"],[["Scott Brown",["4","3","4","3","4","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-2"],["Sang-Moon Bae",["4","2","4","4","5","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Ken Duke",["4","2","4","4","5","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Ryan Moore",["4","2","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Russell Henley",["4","2","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Jimmy Walker",["4","3","3","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Woody Austin",["5","4","4","3","4","4","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Martin Laird",["4","4","4","4","4","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Michael Thompson",["4","3","4","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Patrick Reed",["4","3","4","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Jonas Blixt",["4","3","4","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Harris English",["4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Chris Kirk",["4","3","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Boo Weekley",["4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["John Merrick",["5","3","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"+1"],["Brian Gay",["5","3","4","5","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"+2"],["Derek Ernst",["4","3","6","5","5","4","-","-","-","-","-","-","-","-","-","-","-","-"],"+3"],["D.A. Points","E"],["Bill Haas","E"],["Kevin Streelman","E"],["Gary Woodland","E"],["Jason Dufner","E"],["Billy Horschel","E"],["Brandt Snedeker","E"],["Webb Simpson","E"],["Jordan Spieth","E"],["Matt Kuchar","E"],["Zach Johnson","E"],["Dustin Johnson","E"],["Adam Scott","E"]]]]
  new_api = [["Sony Open in Hawaii","January","9","12","2014","Waialae CC - Honolulu, HI | Par 70 7,044 Yards"],[[],[["Robert Streb"],["Ryuji Imada"],["Paul Goydos"],["Pat Perez"],["Sean O'Hair"],["Morgan Hoffmann"],["D.H. Lee"],["Matt Bettencourt"],["Daniel Chopra"],["Tim Herron"],["Justin Hicks"],["Greg Chalmers"],["William McGirt"],["James Hahn"],["Brian Harman"],["Matt Every"],["Will MacKenzie"],["Jeff Overton"],["Roberto Castro"],["Charlie Beljan"],["Ted Potter, Jr."],["Retief Goosen"],["Robert Allenby"],["Vijay Singh"],["Carl Pettersson"],["D.A. Points"],["John Huh"],["Jimmy Walker"],["Ken Duke"],["Harris English"],["Charles Howell III"],["Rory Sabbatini"],["Adam Scott"],["Jason Dufner"],["Sang-Moon Bae"],["Chris Kirk"],["Matt Kuchar"],["Derek Ernst"],["Kevin Na"],["Justin Leonard"],["Kenny Perry"],["Scott Brown"],["Tommy Gainey"],["Shane Bertsch"],["Scott Langley"],["John Daly"],["Chris Stroud"],["John Rollins"],["Charlie Wi"],["Will Claxton"],["Wes Roach"],["Eric Dugas"],["Billy Hurley III"],["Jamie Lovemark"],["Guan Tianlang"],["Andrew Svoboda"],["Seung-yul Noh"],["Robert Gates"],["Bud Cauley"],["Edward Loar"],["Yusaku Miyazato"],["Hideto Tanihara"],["Jim Herman"],["Russell Knox"],["Mark Anderson"],["Brad Fritsch"],["Chad Collins"],["Masahiro Kawamura"],["Martin Trainer"],["Andrew Loupe"],["Kevin Foley"],["Miguel Angel Carballo"],["Lee Williams"],["Cameron Tringale"],["John Senden"],["Heath Slocum"],["Erik Compton"],["Joe Durant"],["Briny Baird"],["Jerry Kelly"],["Troy Matteson"],["Josh Teater"],["Jason Kokrak"],["Bo Van Pelt"],["David Hearn"],["Brian Stuard"],["Daniel Summerhays"],["Nicholas Thompson"],["Ricky Barnes"],["Michael Putnam"],["Spencer Levin"],["Scott Verplank"],["Johnson Wagner"],["Y.E. Yang"],["Jonathan Byrd"],["Woody Austin"],["Mike Weir"],["Brian Gay"],["Scott Piercy"],["Hideki Matsuyama"],["Russell Henley"],["Jordan Spieth"],["Boo Weekley"],["Zach Johnson"],["K.J. Choi"],["Stewart Cink"],["Tim Clark"],["Michael Thompson"],["Marc Leishman"],["Brendon de Jonge"],["Steven Bowditch"],["Jeff Maggert"],["Stuart Appleby"],["Ryan Palmer"],["Mark Wilson"],["David Lingmerth"],["Fred Funk"],["Derek Tolan"],["Scott Gardiner"],["Troy Merritt"],["John Peterson"],["Tyrone van Aswegen"],["Hudson Swafford"],["Peter Malnati"],["Kevin Tway"],["Ryo Ishikawa"],["Brice Garnett"],["Ben Martin"],["Will Wilcox"],["Kevin Kisner"],["Bronson La'Cassie"],["Kirk Nelson"],["Jim Renner"],["Danny Lee"],["Chesson Hadley"],["Alex Prugh"],["Hyung-Sung Kim"],["Alex Aragon"],["Frank Lickliter II"],["Yuta Ikeda"],["Brendon Todd"],["Tim Wilkinson"],["Toshinori Muto"],["Yan-wei Liu"]]],0]
  
  test "insert new tourn" do
    get("insert_t", {:scores => partial_api.to_s})
    assert_response :success
    
    t = assigns[:t]
    assert_not_nil t, "tournament does not exist"
    assert t.name == "Hyundai Tournament of Champions"
    tplayers = t.tplayers
    
    
    
    get("insert_t", {:scores => new_api.to_s})
    assert_response :success
   
    t = assigns[:t]
    assert_not_nil t, "tournament does not exist"
    tplayers = t.tplayers

    scores = tplayers.map {|t| t.score}.uniq
    assert( scores.length == 1 && scores[0] == 0, "not score is 0 for all players")
    

    
  end
end
