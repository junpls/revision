require 'git'

class WelcomeController < ApplicationController
  
  def index
    @updates = Array.new
    
    git = Git.open(Rails.configuration.x.repo)
    git.log.each do |c|
      if c.message.include? '--hide'
        next
      end

      # hack
      begin
        d.diff_parent.each
        enumerated = c.diff_parent
      rescue
        enumerated = [c.diff_parent]
      end
      
      enumerated.each do |hunk|
        update = Update.create_from_hunk(hunk, c)
        if update
          @updates << update
        end
      end
    end
  end
end
