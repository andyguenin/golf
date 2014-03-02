require 'sinatra'
require 'base64'
require 'json'
require 'openssl'
require "net/http"
require "uri"
require "aescrypt"

set :port, 6001


post '/scores' do 
  unenc_str = JSON.parse(Base64.decode64(params[:payload]))

  unenc_str[1][0] = unenc_str[1][0].map { |u| u.to_i}
  unenc_str[1][1] = unenc_str[1][1].map do |t|
    t.map do |u|
      if u.kind_of?(Array)
        u.map do |v|
          v.to_i
        end
      else
        u
      end
    end
  end
  unenc_str[2] = unenc_str[2].to_i

  unenc = unenc_str
  
  puts unenc.to_s

  password = "RLMMKTeFNtPZEBxsbx8g3Ou0HxniC3l5wAmJUcwsGotZHvbImkOwbPQigcddFWgM"
  encrypted_data = AESCrypt.encrypt(unenc.to_s, password)
  encoded = Base64.encode64(encrypted_data)
  #uri = URI.parse("http://floating-everglades-7438.herokuapp.com/insert")
  uri = URI.parse("http://localhost:3000/insert")
  response = Net::HTTP.post_form(uri, {"scores" => encoded})
  erb response.body 

end

get '/' do
  u2 = [["Hyundai Tournament of Champions","January","3","6","2014","Plantation Course at Kapalua - Kapalua, Maui, HI | Par 73 7,452 Yards"],[["4","3","4","4","5","4","4","3","5","4","3","4","4","4","5","4","4","5"],[["Scott Brown",["4","3","4","3","4","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-2"],["Sang-Moon Bae",["4","2","4","4","5","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Ken Duke",["4","2","4","4","5","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Ryan Moore",["4","2","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Russell Henley",["4","2","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Jimmy Walker",["4","3","3","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"-1"],["Woody Austin",["5","4","4","3","4","4","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Martin Laird",["4","4","4","4","4","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Michael Thompson",["4","3","4","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Patrick Reed",["4","3","4","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Jonas Blixt",["4","3","4","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Harris English",["4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Chris Kirk",["4","3","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["Boo Weekley",["4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"E"],["John Merrick",["5","3","4","-","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"+1"],["Brian Gay",["5","3","4","5","-","-","-","-","-","-","-","-","-","-","-","-","-","-"],"+2"],["Derek Ernst",["4","3","6","5","5","4","-","-","-","-","-","-","-","-","-","-","-","-"],"+3"],["D.A. Points","E"],["Bill Haas","E"],["Kevin Streelman","E"],["Gary Woodland","E"],["Jason Dufner","E"],["Billy Horschel","E"],["Brandt Snedeker","E"],["Webb Simpson","E"],["Jordan Spieth","E"],["Matt Kuchar","E"],["Zach Johnson","E"],["Dustin Johnson","E"],["Adam Scott","E"]]]].to_json
  u1 = [["Sony Open in Hawaii","January","9","12","2014","Waialae CC - Honolulu, HI | Par 70 7,044 Yards"],[[],[["Robert Streb"],["Ryuji Imada"],["Paul Goydos"],["Pat Perez"],["Sean O'Hair"],["Morgan Hoffmann"],["D.H. Lee"],["Matt Bettencourt"],["Daniel Chopra"],["Tim Herron"],["Justin Hicks"],["Greg Chalmers"],["William McGirt"],["James Hahn"],["Brian Harman"],["Matt Every"],["Will MacKenzie"],["Jeff Overton"],["Roberto Castro"],["Charlie Beljan"],["Ted Potter, Jr."],["Retief Goosen"],["Robert Allenby"],["Vijay Singh"],["Carl Pettersson"],["D.A. Points"],["John Huh"],["Jimmy Walker"],["Ken Duke"],["Harris English"],["Charles Howell III"],["Rory Sabbatini"],["Adam Scott"],["Jason Dufner"],["Sang-Moon Bae"],["Chris Kirk"],["Matt Kuchar"],["Derek Ernst"],["Kevin Na"],["Justin Leonard"],["Kenny Perry"],["Scott Brown"],["Tommy Gainey"],["Shane Bertsch"],["Scott Langley"],["John Daly"],["Chris Stroud"],["John Rollins"],["Charlie Wi"],["Will Claxton"],["Wes Roach"],["Eric Dugas"],["Billy Hurley III"],["Jamie Lovemark"],["Guan Tianlang"],["Andrew Svoboda"],["Seung-yul Noh"],["Robert Gates"],["Bud Cauley"],["Edward Loar"],["Yusaku Miyazato"],["Hideto Tanihara"],["Jim Herman"],["Russell Knox"],["Mark Anderson"],["Brad Fritsch"],["Chad Collins"],["Masahiro Kawamura"],["Martin Trainer"],["Andrew Loupe"],["Kevin Foley"],["Miguel Angel Carballo"],["Lee Williams"],["Cameron Tringale"],["John Senden"],["Heath Slocum"],["Erik Compton"],["Joe Durant"],["Briny Baird"],["Jerry Kelly"],["Troy Matteson"],["Josh Teater"],["Jason Kokrak"],["Bo Van Pelt"],["David Hearn"],["Brian Stuard"],["Daniel Summerhays"],["Nicholas Thompson"],["Ricky Barnes"],["Michael Putnam"],["Spencer Levin"],["Scott Verplank"],["Johnson Wagner"],["Y.E. Yang"],["Jonathan Byrd"],["Woody Austin"],["Mike Weir"],["Brian Gay"],["Scott Piercy"],["Russell Henley"],["Jordan Spieth"],["Boo Weekley"],["Zach Johnson"],["K.J. Choi"],["Stewart Cink"],["Tim Clark"],["Michael Thompson"],["Marc Leishman"],["Brendon de Jonge"],["Steven Bowditch"],["Jeff Maggert"],["Stuart Appleby"],["Ryan Palmer"],["Mark Wilson"],["David Lingmerth"],["Fred Funk"],["Derek Tolan"],["Scott Gardiner"],["Troy Merritt"],["John Peterson"],["Tyrone van Aswegen"],["Hudson Swafford"],["Peter Malnati"],["Kevin Tway"],["Ryo Ishikawa"],["Brice Garnett"],["Ben Martin"],["Will Wilcox"],["Kevin Kisner"],["Bronson La'Cassie"],["Kirk Nelson"],["Jim Renner"],["Danny Lee"],["Chesson Hadley"],["Alex Prugh"],["Hyung-Sung Kim"],["Alex Aragon"],["Frank Lickliter II"],["Yuta Ikeda"],["Brendon Todd"],["Tim Wilkinson"],["Toshinori Muto"]]],0].to_json
  u3 = [["Northern Trust Open", "February", "13", "16", "2014", "Riviera CC - Pacific Palisades, CA | Par 71 7,349 Yards"], [[], [["Robert Garrigus"], ["William McGirt"], ["Briny Baird"], ["John Senden"], ["Bo Van Pelt"], ["Jeff Maggert"], ["Richard Lee"], ["Brendon de Jonge"], ["Francesco Molinari"], ["Charlie Wi"], ["Troy Matteson"], ["Luke Guthrie"], ["Justin Hicks"], ["Spencer Levin"], ["Brian Stuard"], ["Graham Delaet"], ["Fred Funk"], ["Joost Luiten"], ["Ian Poulter"], ["Matt Kuchar"], ["Kevin Stadler"], ["John Merrick"], ["Hunter Mahan"], ["Bill Haas"], ["Charl Schwartzel"], ["Dustin Johnson"], ["Ernie Els"], ["Jim Furyk"], ["Justin Rose"], ["Harris English"], ["K.J. Choi"], ["Kyle Stanley"], ["Stewart Cink"], ["Brian Gay"], ["Jhonattan Vegas"], ["Ben Curtis"], ["Robert Allenby"], ["Johnson Wagner"], ["Scott Brown"], ["Geoff Ogilvy"], ["Lucas Glover"], ["Scott Verplank"], ["Davis Love III"], ["Mike Weir"], ["Lee Westwood"], ["Retief Goosen"], ["Ken Duke"], ["Justin Leonard"], ["Scott Piercy"], ["Scott Stallings"], ["David Toms"], ["Y.E. Yang"], ["Stuart Appleby"], ["Russell Henley"], ["Charley Hoffman"], ["David Lingmerth"], ["John Rollins"], ["Daniel Summerhays"], ["Cameron Tringale"], ["Hideki Matsuyama"], ["Brendon Todd"], ["Kevin Chappell"], ["Matt Jones"], ["Padraig Harrington"], ["Victor Dubuisson"], ["David Hearn"], ["Aaron Goldberg"], ["Chesson Hadley"], ["Max Homa"], ["Harold Varner, III"], ["Jim Renner"], ["Michael Putnam"], ["Matt Every"], ["Jason Kokrak"], ["Trevor Immelman"], ["Brian Davis"], ["James Driscoll"], ["Steven Bowditch"], ["Blake Adams"], ["Russell Knox"], ["James Hahn"], ["Freddie Jacobson"], ["David Lynn"], ["Brian Harman"], ["Brendan Steele"], ["Morgan Hoffmann"], ["Martin Flores"], ["Greg Chalmers"], ["Gonzalo Fdez-Castano"], ["Scott Langley"], ["Louis Oosthuizen"], ["Jordan Spieth"], ["Fred Couples"], ["Kevin Streelman"], ["Bubba Watson"], ["Webb Simpson"], ["Ryan Moore"], ["Keegan Bradley"], ["Jason Dufner"], ["Rickie Fowler"], ["Charles Howell III"], ["Jimmy Walker"], ["Harrison Frazar"], ["John Huh"], ["Sang-Moon Bae"], ["Darren Clarke"], ["Angel Cabrera"], ["J.J. Henry"], ["Jonathan Byrd"], ["Carl Pettersson"], ["Tommy Gainey"], ["Ted Potter, Jr."], ["Martin Laird"], ["Marc Leishman"], ["Charlie Beljan"], ["Derek Ernst"], ["Woody Austin"], ["Vijay Singh"], ["Kevin Na"], ["George McNeill"], ["Ben Crane"], ["Andres Romero"], ["Jason Gore"], ["Will MacKenzie"], ["Nicolas Colsaerts"], ["Erik Compton"], ["Josh Teater"], ["Thorbjorn Olesen"], ["Ryo Ishikawa"], ["Nicholas Thompson"], ["Paul Goydos"], ["Ricky Barnes"], ["John Mallinger"], ["Bryce Molder"], ["D.H. Lee"], ["Aaron Baddeley"], ["Pat Perez"], ["J.B. Holmes"], ["Bubba Dickerson"], ["Steve Holmes"], ["Hudson Swafford"], ["Tim Wilkinson"], ["Jason Allred"], ["John Peterson"]]], 0]
  password = "RLMMKTeFNtPZEBxsbx8g3Ou0HxniC3l5wAmJUcwsGotZHvbImkOwbPQigcddFWgM"
  #e1 = AESCrypt.encrypt(u1.to_s, password)
  #en1 = Base64.encode64(e1)
  #uri = URI.parse("http://localhost:3000/insert")  
  #response = Net::HTTP.post_form(uri, {"scores" => en1})
  
  
  #e2 = AESCrypt.encrypt(u2.to_s, password)
  #en2 = Base64.encode64(e2)
  #uri = URI.parse("http://localhost:3000/insert")  
  #response = Net::HTTP.post_form(uri, {"scores" => en2})

  e3 = AESCrypt.encrypt(u3.to_s, password)
  en3 = Base64.encode64(e3)
  uri = URI.parse("http://localhost:3000/insert")  
  response = Net::HTTP.post_form(uri, {"scores" => en3})
  
  erb response.body
end
  