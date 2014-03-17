class InviteMailer < ActionMailer::Base
  default from: "\"TheGolfTourney.com\" <invite@thegolftourney.com>"
  
  def i(user, invite)
    @user = user
    @link = "/users/activate/?activation=#{invite.activation_key}&email=#{user.email}"
    mail(:to => user.email, :subject => "You have been invited to join a pool")
  end

  def invite(user)
    @user = user
    @link = "abcdefg"
    mail(:to => user.email, :subject => "this is a test")
  end
end
