class HomeController < ApplicationController
  before_action :check_redirect_to_landing, only: :show

  def show; end

  private

  def check_redirect_to_landing
    if !giver || !receiver || receiver.giver_id != giver.id
      redirect_to landing_show_path
    end
  end
end
