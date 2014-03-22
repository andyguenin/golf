class InviteMailer < ActionMailer::Base
 default from: "\"TheGolfTourney.com\" <invite@thegolftourney.com>"
  
  def invite(user, invite)
    @user = user
    @inviter = invite.inviter.name
    @link = "http://thegolftourney.com/users/activate/?activation=#{invite.activation_key}&email=#{user.email}"
    mail(:to => user.email, :subject => "You have been invited to join a pool at The Golf Tourney")
  end
  
  def forgot_password(user)
    @user = user
    @link = "http://thegolftourney.com/users/reset?key=#{user.forgot_password}&email=#{user.email}"
    mail(:to => user.email, :subject => "Reset your password")
  end
end
