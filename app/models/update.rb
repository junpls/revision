class Update
  def initialize
    @date = Time.at(rand * Time.now.to_i);
    @author = "jan"
    @type = :update
    @article = Article.new
  end

  def day
    @date.mday
  end

  def month
    @date.strftime('%b')
  end

  def author
    @author
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

  def update_snippet
    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. <span class=\"added\">At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</span> At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
  end
end
