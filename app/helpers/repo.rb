require 'git'

module Repo
  @@flag_hidden = '--hide'

  @git = Git.open(Rails.configuration.x.repo)

  def self.each_commit(path='.', offset=Time.now, count=10)
    num = count
    puts path
    @git.log.until(offset.strftime('%Y-%m-%d %H:%M:%S')).path(path).each do |c|
      if (not is_hidden? c) && num != 0
        yield c
        num = num - 1
      end
    end
  end
  
  def self.each_hunk(path='.', offset=Time.now, count=10)
    each_commit(path, offset, count) do |c|
      # hack
      begin
        d.diff_parent.each
        enumerated = c.diff_parent
      rescue
        enumerated = [c.diff_parent]
      end
      
      enumerated.each do |hunk|
        yield [hunk, c]
      end
    end
  end

  def self.current
    @git.current
  end

  def self.get_commit(sha)
    @git.gcommit(sha)
  end

  def self.show(sha, file)
    @git.show(sha, file)
  end

  def self.diff_file(file, sha1, sha2)
    @git.diff(sha1, sha2).path(file)
  end

  def self.is_hidden?(commit)
    return commit.message.include? @@flag_hidden
  end

  def self.is_ignored?(namepath)
    Rails.configuration.x.settings["ignore"].each do |ignored|
      if namepath.include? ignored
        return true
      end
    end
    return false
  end

end
