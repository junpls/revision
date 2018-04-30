require 'repo'

class ArticlesController < ApplicationController

  def show
    # parse path
    path = params[:path]
    if path !~ /^[^\+]+\/.*\..+$/
      raise ActionController::RoutingError.new('Not Found')
      return
    end

    # render article
    @article = Article.create_from_file(path)

    # assemble history
    @history = Array.new
    Repo.each_commit(path) do |commit|
      @history << {
        :name => commit.message,
        :date => commit.date.strftime('%Y-%m-%d')
      }
    end

    @test = 'toast'
    
  end

end
