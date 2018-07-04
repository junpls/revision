# REVISION
Revision is a blogging system built on top of git. Each commit is visualized as a blog post. Contrary to traditional blogs, the point of revision is not to release finished articles all at once, but to let your audience follow your process of writing them.  
Here's an [example](https://jabens.tools/blog) of how this could look like.

## Setting up Revision
You'll need:
* Ruby (> 2.3.1)
* Rails (> 5.1.4)

1. Clone or download the repository and `cd` there.
1. `$ bundle install`
1. In *config/application.rb*, adjust
   ```ruby
   config.x.repo = "/path/to/repository"
   ```
   to make it point to your blog repository.
1. (Optional) To deploy Revision in a sub-directory (e.g. mydomain.com/blog), adjust this line like so:
   ```ruby
   config.relative_url_root = "/blog"
   ```
   A corresponding Nginx configuration can be found [here]().
1. `$ ./bin/rails server`

## Setting up the blog repository
1. Have a local git repository that is accessible by your Revision instance.  
   You can do this by:
   1. [Setting up your own server](https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server) and cloning.  
   Suggested read: Setting up a [git hook](https://gist.github.com/noelboss/3fe13927025b89757f8fb12e9066f2fa) for automating updates.
   1. Setting up a local repository and make your edits directly there. (no remote needed)
   1. Hosting the repo remotely and cloning.
1. Your repository shoud have a structure like this:
   ```
   blog (project root)
   |   revision.yml
   |
   └── category1
   |   |   Hello_World.md
   |   |   My_Other_Article.md
   |   |
   |   └── media
   |       |
   |       |   helloworld.jpg
   |
   └── category2
   |   ...
   ```
1. Populate [revision.yml](#Configuration)

## Configuration
```yaml
### revision.yml

# The blog's title
title: My Awesome Blog

# As this is git, you cannot "delete" a post,
# but you can place it here and Revision won't render it.
# A file will be ignored, if its name+path (relative to blog root)
# contains an entry of this list as a substring.
ignore:
  - 10_Reasons_why_Nickleback_rock
  - category1/My_Other_Article.md
```
Remember to restart Revision after editing this file.

## Authoring articles
* Revision articles are written in [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet), but you can also use inline html. I would suggest to use markdown as much as possible though.  
* Embedding images that reside within the blog repository should be done like so:
   ```markdown
   ### Hello_World.md

   [Alternative text](/media/helloworld.jpg "Caption")
   ```
* Revision will automatically resolve such paths relative to the article.  
* Get familiar with git's `--amend` option. You will use it frequently.  
* Use meaningful commit messages, as they will appear in the timeline of your article.

### Commands
You can place these commands anywhere in the commit message:

* **--hide** Don't show this commit in the feed and the timeline. You can use this e.g. for spelling corrections if it is too late to just `--amend` the last commit.
* **--tag="tag name"** Tag a version of your article. A tagged version will be highlighted in the acticle's timeline. (not yet implemented)