require 'git'
require 'redcarpet'

class WelcomeController < ApplicationController
  @@repo_path = './../blog2'
  @@text_padding_lines = 1
  
  def index
    @updates = Array.new
    
    git = Git.open(@@repo_path)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true, prettify: true)

    git.log.each do |c|
      if c.message.include? '--hide'
        next
      end
      c.diff_parent.each do |d|
        title, patch = d.patch.split(/@@.*@@/)
        if not title.match(/.*\.md/)
          next
        end
        title = title.match(/\/([^\/]*)\.md/).captures[0]
        title = title.gsub("_"," ")
        pre, new, suf = "", "", ""
        foundpatch = false
        patch.each_line do |line|
          if line[0] == '+'
            next
          elsif line[0] == '-'
            foundpatch = true
            new += line[1..-1]
          elsif foundpatch
            suf += line[1..-1]
          else
            pre += line[1..-1]
          end
        end

        pre = pre.split("\n").last(@@text_padding_lines).join("\n")
        suf = suf.split("\n").first(@@text_padding_lines).join("\n")
        
        pre_patch = markdown.render(pre)
        new_patch = markdown.render(new)
        suf_patch = markdown.render(suf)

        if pre == "" && suf == ""
          patch = new_patch
          patch_type = :publish
        else
          patch = '<div class="pre_insertion">'  + pre_patch + '</div>' +
                  '<div class="insertion">'      + new_patch + '</div>' +
                  '<div class="post_insertion">' + suf_patch + '</div>'
          patch_type = :update
        end
        
        update = Update.new(c.committer_date, c.committer.name, patch_type, patch, title)
        @updates << update
       end
    end
  end
end
