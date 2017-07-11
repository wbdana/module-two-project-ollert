class SessionsController < ApplicationController

  def new

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
      redirect_to '/'
    end
  end

  def destroy
    session[:employee_id] = nil
    redirect_to login_path
  end


end
