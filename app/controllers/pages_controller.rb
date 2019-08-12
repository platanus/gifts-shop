class PagesController < ApplicationController
  def home; end

  def landing; end

  def start
    # temp: forced to region Chile
    @giver = Giver.new(region_id: 1)
    if @giver.save!
      set_cookies(@giver.id)
      # temp: forced to relation Mamá
      @receiver = Receiver.new(name: params[:name], giver_id: @giver.id, relation_id: 2)
      if @receiver.save!
        redirect_to pages_home_path(name: params[:name])
      end
    end
  end

  def user_helper
    if cookies[:giver_id]
      redirect_to pages_home_path
    else
      redirect_to pages_landing_path
    end
  end

  def set_cookies(giver_id)
    cookies[:giver_id] = giver_id
  end

  def show_cookies
    @giver_id = cookies[:giver_id]
  end
end
