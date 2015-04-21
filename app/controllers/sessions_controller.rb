class SessionsController < ApplicationController
	layout 'login'
	def new
	end

	def create
    	admin = Admin.login(params) 
    	if admin.is_a?(Admin)
    	  refresh_session(admin.id.to_s)
    	end
    	render_json_auto admin
	end

	def destroy	
		refresh_session()
		redirect_to login_path
	end


end