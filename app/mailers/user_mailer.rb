class UserMailer < ActionMailer::Base
 default from: "\"TheGolfTourney.com\" <invite@thegolftourney.com>"
  
  def invite(user, invite, message)
    @user = user
    @inviter = invite.inviter.name
    @link = "http://thegolftourney.com/users/activate/?activation=#{invite.activation_key}&email=#{user.email}"
    @message = message
    mail(:to => user.email, :subject => "#{@inviter} has invited you to join a pool at The Golf Tourney")
  end
  
  def forgot_password(user)
    @user = user
    @link = "http://thegolftourney.com/reset/#{user.forgot_password}/#{user.username}"
    mail(:to => user.email, :subject => "Reset your password")
  end
  
end
