class ArticlesController < ApplicationController

  def show
    path = params[:path]
    if path !~ /^[^\+]+\/.*\..+$/
      raise ActionController::RoutingError.new('Not Found')
      return
    end
    @article = Article.create_from_file(path)
  end
  
end
