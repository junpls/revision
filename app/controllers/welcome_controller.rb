require 'git'
require 'repo'

class WelcomeController < ApplicationController
  @@updates_per_page = 10

  def index
    @updates = Array.new
    @page = 1

    offset = 0
    if params.has_key?(:page) and /\A\d+\z/.match(params[:page])
      @page = params[:page].to_i;
      offset = @@updates_per_page * (@page - 1)
    end

    Repo.each_hunk('', offset, @@updates_per_page) do |hunk, c|
      update = Update.create_from_hunk(hunk, c)
      if update && !update.article.is_ignored?
        @updates << update
      end
    end
  end
end
