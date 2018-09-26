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

    pred_sha = ''
    prev_sha = ''

    # assemble history
    @history = Array.new
    Repo.each_commit(path, 0, -1) do |commit|
      @history << {
        :name => commit.message,
        :date => commit.date.strftime('%Y-%m-%d %H:%M:%S'),
        :sha => commit.sha,
        :selected => commit.sha == @sha
      }

      if prev_sha == @sha
        pred_sha = commit.sha
      end
      prev_sha = commit.sha
    end

    # render article
    begin
      article = Article.create_from_commit(path, @sha)
    rescue
      not_found
    end
    if !article.is_ignored?
      @article = article
    else
      not_found
    end
  end

end
