require 'git'

class WelcomeController < ApplicationController
  @@repo_path = './../blog2'
  
  def index
    @updates = Array.new
    
    git = Git.open(@@repo_path)
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
