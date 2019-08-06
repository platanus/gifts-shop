class PagesController < ApplicationController
  def home
    @relations = Relation.all
  end
end
