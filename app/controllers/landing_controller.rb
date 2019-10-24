class LandingController < ApplicationController
  before_action :check_for_receiver, only: :show
  before_action :set_giver, only: :search

  DEFAULT_REGION = ENV.fetch('DEFAULT_REGION', 1).to_i
  def show; end

  def search
    create_giver_and_receiver
    save_giver_session(@giver.id)
    save_receiver_session(@receiver.id)
    redirect_to home_path
  end

  def save_giver_session(giver_id)
    session[:giver_id] = giver_id
  end

  def save_receiver_session(receiver_id)
    session[:receiver_id] = receiver_id
  end

  private

  def check_for_receiver
    search if params[:name]
  end

  def set_giver
    @giver = Giver.find_by(id: session[:giver_id])
  end

  def create_giver_and_receiver
    @giver = Giver.create!(region_id: DEFAULT_REGION) if @giver.blank?
    @receiver = Receiver.create!(
      name: params[:name],
      giver_id: @giver.id
    )
  end
end
