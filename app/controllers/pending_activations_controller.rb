class PendingActivationsController < ApplicationController
	before_action :logged_in_user, only: :index
  before_action :admin_user,     only: :index

	def index
		@pending_activations = User.where(activated: false).paginate(page: params[:page])
	end

	# In this context, @user is not the current user, rather the user whose activation is pending.
	def edit
		@user = User.find(params[:id])
    @user.send_activation_email
    flash[:info] = "User Approved."
    redirect_to root_url
	end

end
