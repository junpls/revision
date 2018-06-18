require 'repo'

class ArticlesController < ApplicationController

  def show
    # parse path
    path = params[:path]
    if path !~ /^[^\+]+\/.*\..+$/
      raise ActionController::RoutingError.new('Not Found')
      return
    end

    @sha = params[:sha]

    # render article
    @article = Article.create_from_commit(path, @sha)
    
    # assemble history
    @history = Array.new
    Repo.each_commit(path) do |commit|
      @history << {
        :name => commit.message,
        :date => commit.date.strftime('%Y-%m-%d'),
        :sha => commit.sha,
        :selected => commit.sha == @sha
      }
    end

  end

end
