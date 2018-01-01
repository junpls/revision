class WelcomeController < ApplicationController
  def index
    @updates = [ Update.new, Update.new]
  end
end
