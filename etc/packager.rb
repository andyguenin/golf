require 'sinatra'
require 'base64'
require 'json'
require 'openssl'

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

  cipher = OpenSSL::Cipher::Cipher.new("aes-256-cbc")
  cipher.encrypt
  
  key = Digest::SHA1.hexdigest("RLMMKTeFNtPZEBxsbx8g3Ou0HxniC3l5wAmJUcwsGotZHvbImkOwbPQigcddFWgM")
  iv = cipher.random_iv
  
  cipher.key = key
  cipher.iv = iv
  
  encrypted = cipher.update(unenc.to_s)
  encrypted << cipher.final
  
  erb encrypted.to_s
  #todo: send to server
  
end
