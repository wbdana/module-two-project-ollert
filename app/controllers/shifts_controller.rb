class ShiftsController < ApplicationController

  before_action :find_shift, only: [:show, :edit, :destroy, :update]

  before_action :authorize

  def index
    @shifts = Shift.all
    @shifts = @shifts.sort_by {|shift| shift.day}
    @store_id = params[:store_id] if params.keys.include?("store_id")
    @store = Store.find(@store_id) if @store_id
  end

  def new
    @shift = Shift.new
    @store = Store.find(params[:store_id])
    5.times do |i|
      @shift.tasks << Task.new
    end
    @managers = Employee.where(is_manager: true, store:  @store).map{|manager| ["#{manager.name}", "#{manager.id}"]}
    @employees = Employee.where(is_manager: false, store: @store)
  end

  def create
    @shift = Shift.new(shift_params)
    params[:shift][:employee_ids].shift
    params[:shift][:employee_ids].each do |id|
      @shift.employees << Employee.find(id.to_i)
    end
    @shift.employees << Employee.find(@shift.manager_id)
    params[:shift][:tasks_attributes].values.each do |desc_hash|
      desc_hash[:description] == "" ? @shift.tasks << Task.create(description: " ") : @shift.tasks << Task.create(description: desc_hash[:description])
    end
    @shift.save

    if @shift.errors.full_messages == []
      redirect_to shift_path(@shift)
    else
      redirect_to new_store_shift_path(@shift.manager.store) + "?errors=#{@shift.errors.full_messages.first}"
    end

  end

  def show
    @shift = Shift.find(params[:id])
  end

  def edit
    @shift = Shift.find(params[:id])
    @store = Store.find(@shift.manager.store.id)
    @managers = Employee.where(is_manager: true, store:  @store).map{|manager| ["#{manager.name}", "#{manager.id}"]}
    @employees = Employee.where(is_manager: false, store: @store)
  end

  def update
    @shift.update(shift_params)
    params[:shift][:employee_ids].shift
    @shift.tasks = []
    params[:shift][:tasks_attributes].values.each do |desc_hash|
      @shift.tasks << Task.create(description: desc_hash[:description])
    end
    @shift.employees = []
    params[:shift][:employee_ids].each do |id|
      @shift.employees << Employee.find(id.to_i)
    end
    @shift.employees << Employee.find(@shift.manager_id)
    @shift.save

    if @shift.errors.full_messages == []
      redirect_to shift_path(@shift)
    else
      redirect_to edit_store_shift_path(@shift.manager.store) + "?errors=#{@shift.errors.full_messages.first}"
    end
  end

  #TODO fix this method

  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy
    redirect_to '/'
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
