class DashboardsController < ApplicationController

  def show
    self.send(params[:id].to_sym) if DashboardsController.method_defined?(params[:id].to_sym)
    render params[:id]
  end

  def landing
  end

end
