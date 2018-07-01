require 'renderers'
require 'repo'

class Article
  attr_accessor :title, :filename, :folder, :content

  @@markdown_renderer = MarkdownRenderer.new

  def self.create_from_hunk(path)
    article = Article.new

    article.filename = path.match(/.*\/(.*\.md)/).captures[0]
    article.title = article.filename[0..-4]
                      .gsub("_"," ")
                      .gsub("\\","")
    article.folder = path.match(/([^\/]*).*/).captures[0]

    return article
  end

  def self.create_from_file(path)
    article = Article.create_from_hunk(path)
    article.content = File.read("#{Rails.configuration.x.repo}/#{article.path}")
    article.content = "<h1>#{article.title}</h1>#{article.content}"
    return article
  end

  def self.create_from_commit(path, sha)
    article = Article.create_from_hunk(path)
    article.content = Repo.show(sha, path)
    #puts Repo.get_commit(sha)
    article.content = "<h1>#{article.title}</h1>\n#{article.content}"
    return article
  end

  def self.create_from_diff(path, sha1, sha2)
    article = Article.create_from_hunk(path)
    article.content = Repo.diff_file(path, sha1, sha2)
    article.content = "<h1>#{article.title}</h1>\n#{article.content}"
    return article
  end

  def href
    "/articles/#{@folder}/#{@filename.gsub('\\','')}"
  end

  def path
    "#{@folder}/#{@filename}"
  end

  def render(patch = nil)
    if (!patch)
      patch = @content
    end
    patch = prepare_images(patch)
    patch = render_text(patch)
    return patch
  end
  
  def prepare_images(patch)
    patch.gsub(/]\((.*.(?:jpg|jpeg|gif|png))\s"(.*)"\)/, 
      "](#{Rails.configuration.relative_url_root}/assets/#{@folder}\\1  \"\\2\")  "+"\n")
  end

  def render_text(raw)
    @@markdown_renderer.render(raw)
  end

  def is_ignored?
    Repo.is_ignored?(path)
  end
end
