class HomeController < ApplicationController
  before_action :set_cold_start

  def show; end

  private

  def set_cold_start
    session[:cold] = true
  end
end
