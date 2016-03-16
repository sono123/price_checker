class PendingActivationsController < ApplicationController
	before_action :logged_in_user, only: :index
  before_action :admin_user,     only: :index

	def index
		@pending_activations = User.where(activated: false).paginate(page: params[:page])
	end

end
