class StoreController < ApplicationController
  DEFAULT_REGION = ENV.fetch('DEFAULT_REGION', 1).to_i
  def register; end

  def login; end
end
