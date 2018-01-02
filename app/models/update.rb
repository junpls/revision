class Update
  attr_accessor :diff
  
  def initialize(date, author, type, diff, title)
    @date = date
    @author = author
    @type = type
    @article = Article.new(title)
    @diff = diff
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

    end
  end

  def article
    @article
  end

  def diff_snippet
    @diff
  end
end
