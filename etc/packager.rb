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
  unenc = unenc_str.map do |t|
    t.map do |u|
      if u.kind_of?(Array)
        u.map {|v| v.to_i}
      else
        u
      end
    end
  end

  password = "RLMMKTeFNtPZEBxsbx8g3Ou0HxniC3l5wAmJUcwsGotZHvbImkOwbPQigcddFWgM"
  encrypted_data = AESCrypt.encrypt(unenc.to_s, password)
  encoded = Base64.encode64(encrypted_data)
  uri = URI.parse("http://localhost:3000/insert")
  response = Net::HTTP.post_form(uri, {"scores" => encoded})
  erb response.body 

end
