class ShiftsController < ApplicationController

  before_action :find_shift, only: [:show, :edit, :destroy, :update]

  def index
    @shifts = Shift.all
    @store_id = params[:store_id] if params.keys.include?("store_id")
    @store = Store.find(@store_id) if @store_id
    @manager_id = params[:manager_id] if params.keys.include?("manager_id")
    @manager = Employee.find(@manager_id) if @manager_id
    @employee_id = params[:employee_id] if params.keys.include?("employee_id")
    @employee = Employee.find(@employee_id) if @employee_id
  end

  def new
    @shift = Shift.new
    @managers = Employee.where(is_manager: true).map{|manager| ["#{manager.name}", "#{manager.id}"]}
    @employees = Employee.where(is_manager: false)
  end

  def create
    @shift = Shift.create(shift_params)
    params[:employee_ids].each do |id|
      @shift.employees << Employee.find(id.to_i)
    end
    redirect_to @shift
  end

  def show
    @shift = Shift.find(params[:id])

  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def update
    @shift.update(shift_params)
    @shift.save
    redirect_to @shift
  end

  def destroy
  end

  def show_params
  end

  private
    def shift_params
      params.require(:shift).permit(:day, :manager_id, :employee_ids, :start_time, :end_time)
    end

    def find_shift
      @shift = Shift.find(params[:id])
    end

end
