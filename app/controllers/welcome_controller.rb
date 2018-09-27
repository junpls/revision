require 'git'
require 'repo'

class WelcomeController < ApplicationController
  @@updates_per_page = 10

  def index
    @updates = Array.new
    @page = 1

    @offset = Time.now
    if params.has_key?(:page) and /\A\d+\z/.match(params[:page]) and
      params.has_key?(:start) and /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/.match(params[:start])
      @page = params[:page].to_i
      @offset = Time.parse(params[:start])
    end

    @last = Time.now
    Repo.each_hunk('', @offset, @@updates_per_page) do |hunk, c|
      update = Update.create_from_hunk(hunk, c)
      if update && !update.article.is_ignored?
        @updates << update
        @last = update.date_as_string
      end
    end
  end
end
