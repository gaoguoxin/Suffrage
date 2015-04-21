class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  has_mobile_fu

  def current_user
    @current_user || Admin.where(id:cookies[:auth_key]).first
  end

  def require_sign_in
    redirect_to login_path and return unless current_user.present?
  end  

  def refresh_session(userid=nil)
    if userid.present?
      @current_user = Admin.find(userid)
      cookies[:auth_key] = {
        :value => userid,
        :expires => Rails.application.config.permanent_signed_in_months.months.from_now,
        :domain => :all
      }
    else
      cookies.delete(:auth_key, :domain => :all)
    end
  end

  def render_json(is_success = true, &block)
    @is_success = is_success.present?
    render :json => {
                :value => block_given? ? yield(is_success) : is_success ,
                :success => !!@is_success
              }
  end

  def render_json_e(error_code)
    error_code_obj = {
      :error_code => error_code,
      :error_message => ""
    }
    render_json false do 
      error_code_obj
    end
  end

  def render_json_s(value = true, options={})
    render_json true do 
      value
    end
  end

  def render_json_auto(value = true, options={})
    is_success = !((value.class == String && value.start_with?('error_')) || value.to_s.to_i < 0)
    is_success ? render_json_s(value, options) : render_json_e(value)
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def render_500
    raise '500 exception'
  end

end
