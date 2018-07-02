# REVISION

## Setting up Revision
You'll need:
* Ruby (> 2.3.1)
* Rails (> 5.1.4)

1. Clone or download the repository and `cd` there
1. `$ bundle install`
1. In *config/application.rb*, adjust
   ```ruby
   config.x.repo = "/path/to/repository"
   ```
   to make it point to your blog repository
1. (Optional) To deploy Revision in a sub-directory (e.g. mydomain.com/blog), adjust this line like so:
   ```ruby
   config.relative_url_root = "/blog"
   ```
   A corresponding Nginx configuration can be found [here]()
1. `$ ./bin/rails server`

## Setting up the blog repository
1. Have a local git repository that is accessible by your Revision instance.  
   You can do this by:
   1. [Setting up your own server](https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server) and cloning.  
   Suggested read: Setting up a [git hook](https://gist.github.com/noelboss/3fe13927025b89757f8fb12e9066f2fa) for automating updates.
   1. Setting up a local repository and make your edits directly there (no remote needed)
   1. Hosting the repo remotely and cloning   
1. Your repository shoud have a structure like this:
   ```
   blog (project root)
   |   revision.yml
   |
   └── category1
   |   |   Hello_World.md
   |   |   My_Other_Post.md
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
  - category1/My_Other_Post.md
```
Remember to restart Revision after editing this file.

## Commands
You can place those commands somewhere in the commit messages

* **--hide** Hide this commit in the feed 
* **--amend** Show this commit in the feed instead of the preceding one (not yet implemented)
* **--tag="tag name"** Tag a version of your article (not yet implemented)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
