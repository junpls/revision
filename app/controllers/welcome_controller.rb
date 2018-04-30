require 'git'
require 'repo'

class WelcomeController < ApplicationController
  
  def index
    @updates = Array.new

    Repo.each_hunk do |hunk, c|
      update = Update.create_from_hunk(hunk, c)
      if update
        @updates << update
      end
    end
  end
end
