class UsersController < ApplicationController
	layout 'admin'
	before_filter :require_sign_in
	def  index
		@users = User.desc(:created_at).page(params[:page]).per(10)
	end
end