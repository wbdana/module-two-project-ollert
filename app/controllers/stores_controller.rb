class StoresController < ApplicationController

  before_action :authorize

  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
  end

  def redirect
    redirect_to '/stores/'
  end

end
