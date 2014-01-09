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
  puts Base64.decode64(params[:payload])
#  return

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

  password = "RLMMKTeFNtPZEBxsbx8g3Ou0HxniC3l5wAmJUcwsGotZHvbImkOwbPQigcddFWgM"
  encrypted_data = AESCrypt.encrypt(unenc.to_s, password)
  encoded = Base64.encode64(encrypted_data)
  #uri = URI.parse("http://floating-everglades-7438.herokuapp.com/insert")
  uri = URI.parse("http://localhost:3000/insert")
  response = Net::HTTP.post_form(uri, {"scores" => encoded})
  erb response.body 

end
