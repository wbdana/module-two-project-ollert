class SessionsController < ApplicationController

  def new
    if logged_in_employee
      redirect_to current_user
    elsif logged_in_manager
      redirect_to "/stores/#{current_user.store_id}"
    end
  end

  def create
    @employee = Employee.find_by(email: params[:email])
    if @employee && @employee.authenticate(params[:password])
      session[:employee_id] = @employee.id
      if @employee.is_manager == false
        redirect_to @employee
      else
        redirect_to "/stores/#{@employee.store_id}"
      end
    else
      flash[:notice] = "Invalid login, please try again!"
      redirect_to '/'
    end
  end

  def destroy
    session[:employee_id] = nil
    redirect_to login_path
  end

end
