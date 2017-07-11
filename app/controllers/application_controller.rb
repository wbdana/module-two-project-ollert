class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in, :logged_in_manager, :logged_in_employee, :current_user, :authorize

  def logged_in
    !!session[:employee_id]
  end

  def logged_in_manager
    logged_in && Employee.find(session[:employee_id]).is_manager
  end

  def logged_in_employee
    logged_in && !Employee.find(session[:employee_id]).is_manager
  end

  def current_user
    @current_user ||= Employee.find(session[:employee_id]) if session[:employee_id]
  end

  def authorize
    redirect_to '/login' unless current_user
  end

end
