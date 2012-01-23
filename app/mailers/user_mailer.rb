class UserMailer < ActionMailer::Base
  default :from => "from@sample_app.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def new_follower(follower, followed)
    @follower = follower
    @followed = followed
    mail :to => followed.email, :subject => "You have a new follower!"
  end
end
