class Stores::PaymentsController < ApplicationController
  layout 'stores'
  before_action :authenticate_store!

  def about; end
end
