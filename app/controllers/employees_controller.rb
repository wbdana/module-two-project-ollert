class EmployeesController < ApplicationController

  before_action :authorize, except: [:create]

  def new
    @employee = Employee.new
    @stores = Store.all.map{|store| ["#{store.name}", "#{store.id}"]}
  end

  def create
    @employee = Employee.create(employee_params)
    if @employee.save
      session[:employee_id] = @employee.id
      if @employee.is_manager
        redirect_to store_path(@employee.store_id)
      else
        redirect_to @employee
      end
    elsif @employee.errors.full_messages.length>0
      redirect_to new_employee_path
    else
      redirect_to '/login'
    end
  end

  def show
    @employee = Employee.find(params[:id])
  end

  private
    def employee_params
      params.require(:employee).permit(:name, :password, :password_confirmation, :store_id, :is_manager, :email)
    end

end
