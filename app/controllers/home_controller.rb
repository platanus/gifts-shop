class HomeController < ApplicationController
  def show
    response.headers.delete('X-Frame-Options')
  end
end
