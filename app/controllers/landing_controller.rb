class LandingController < ApplicationController
  DEFAULT_REGION = ENV.fetch('DEFAULT_REGION', 1).to_i
  DEFAULT_RELATION = ENV.fetch('DEFAULT_RELATION', 2).to_i
  def show; end

  def search
    create_giver_and_receiver
    save_giver_cookies(@giver.id)
    save_receiver_cookies(@receiver.id)
    redirect_to home_path
  end

  def save_giver_cookies(giver_id)
    cookies[:giver_id] = giver_id
  end

  def save_receiver_cookies(receiver_id);
    cookies[:receiver_id] = receiver_id
  end

  private

  def create_giver_and_receiver
    @giver = Giver.create!(region_id: DEFAULT_REGION)
    @receiver = Receiver.create!(
      name: params[:name],
      giver_id: @giver.id,
      relation_id: DEFAULT_RELATION
    )
  end
end
