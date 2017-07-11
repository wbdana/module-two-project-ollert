class EmployeesController < ApplicationController

  def new
    
  end

  def create

  end

  def show
    @employee = Employee.find(params[:id])
  end
end
