require 'redcarpet'

class MarkdownRenderer
  class HtmlRenderer < Redcarpet::Render::HTML

    def initialize
      super(prettify: true, with_toc_data: true);
    end
    
    def image(link, title, alt_text)
      caption = title.to_s.empty? ? "" : %(<div class="caption">#{title}</div>)
      %(<div class="center"><img class="figure" src="#{link}" alt="#{alt_text}"></img>#{caption}</div>)
    end

    def block_code(code, language)
      %(<div><code>#{code}</code></div>)
    end

    def header(text, level)
      %(#{level == 1 ? "</br>":""}<h#{level}>#{text}</h#{level}>)
    end
  end
  
  def initialize
    @renderer = Redcarpet::Markdown.new(HtmlRenderer, fenced_code_blocks: true, tables: true)
  end

  def render(raw)
    @renderer.render(raw)
  end
end
