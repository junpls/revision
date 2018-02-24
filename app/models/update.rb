require 'renderers'

class Update
  attr_accessor :diff
  @@markdown_renderer = MarkdownRenderer.new
  @@text_padding_lines = 1
  
  def initialize(date, author, type, diff, title)
    @date = date
    @author = author
    @type = type
    @article = Article.new(title)
    @diff = diff
  end

  def self.create_from_hunk(hunk, commit)
    log, hunk = hunk.patch.split(/@@.*@@/)
    if not log.match(/.*\.md/)
      return nil
    end
    
    path = log.match(/.*(b\/.*)\.md/).captures[0]
    title = path.match(/.*\/([^\/]*)/).captures[0]
    title = title.gsub("_"," ")
              .gsub("\\","")

    folder = path.match(/b\/([^\/]*).*/).captures[0]
    
    pre, new, suf = "", "", ""
    foundpatch = false
    hunk.each_line do |line|
      if line[0] == '+'
        next
      elsif line[0] == '-'
        foundpatch = true
        new += line[1..-1]
      elsif foundpatch and line[0] == ' '
        suf += line[1..-1]
      elsif line[0] == ' '
        pre += line[1..-1]
      end
    end

    if new == ""
      return nil
    end

    pre = pre.split("\n").last(@@text_padding_lines).join("\n")
    suf = suf.split("\n").first(@@text_padding_lines).join("\n")

    pre = prepare_images(pre, folder)
    new = prepare_images(new, folder)
    suf = prepare_images(suf, folder)
    
    pre_patch = render_text(pre)
    new_patch = render_text(new)
    suf_patch = render_text(suf)

    if pre == "" && suf == ""
      patch = new_patch
      patch_type = :publish
    else
      patch = '<div class="pre_insertion">'  + pre_patch + '</div>' +
              '<div class="insertion">'      + new_patch + '</div>' +
              '<div class="post_insertion">' + suf_patch + '</div>'
      patch_type = :update
    end

    return Update.new(commit.committer_date, commit.committer.name, patch_type, patch, title)
  end
    
  def type
    @type
  end

  def day
    @date.mday
  end

  def month
    @date.strftime('%b')
  end

  def author
    @author.split(" ")[0]
  end

  def type_as_string
    case @type
    when :update
      "updated"
    when :publish
      "published"
    end
  end

  def article
    @article
  end

  def diff_snippet
    @diff
  end

  def href
    "/articles/"+@article.title
  end

  private
    def self.prepare_images(patch, folder)
      patch.gsub(/]\((.*.(?:jpg|jpeg|gif|png))\s"(.*)"\)/, '](/assets/'+folder+'\1 "\2")  '+"\n")
    end

    def self.render_text(raw)
      @@markdown_renderer.render(raw)
    end
end
