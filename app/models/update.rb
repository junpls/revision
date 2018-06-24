class Update
  attr_accessor :diff, :date, :author, :type, :diff, :article
  @@text_padding_lines = 1

  def self.create_from_hunk(hunk, commit)
    log, hunk = hunk.patch.split(/@@.*@@/)
    if not log.match(/.*\.md/)
      return nil
    end

    path = log.match(/.*b\/(.*\.md)/).captures[0]
    article = Article.create_from_hunk(path)
    
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

    pre_patch = article.render(pre)
    new_patch = article.render(new)
    suf_patch = article.render(suf)

    if pre == "" && suf == ""
      patch = new_patch
      patch_type = :publish
    else
      patch = '<div class="pre_insertion"><div class="snippet">'  + pre_patch + '</div></div>' +
              '<div class="insertion"><div class="snippet">'      + new_patch + '</div></div>' +
              '<div class="post_insertion"><div class="snippet">' + suf_patch + '</div></div>'
      patch_type = :update
    end
    
    update = Update.new
    update.date = commit.committer_date
    update.author = commit.committer.name
    update.type = patch_type
    update.diff = '<div class="insertionWrapper">' + patch + '</div>'
    update.article = article
    
    return update
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

end
