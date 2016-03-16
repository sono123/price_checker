class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  def admin_request(admin, user)
  	@admin = admin
  	@user = user
  	mail to: admin.email, subject: "New User Awaiting Approval"
  end

  def password_reset(user)
  	@user = user
  	mail to: user.email, subject: "Password Reset"
  end
end
