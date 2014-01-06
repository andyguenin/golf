class InviteMailer < ActionMailer::Base
  default from: "\"TheGolfTourney.com\" <invite@thegolftourney.com>"
  
  def invite(user, invite)
    @user = user
    @link = "/users/activate/?activation=#{invite.activation_key}&email=#{user.email}"
    mail(:to => user.email, :subject => "You have been invited to join a pool")
  end
end
