class BookmarkFactory
  def initialize(user, save: true)
    @user = user
    @last_id = Bookmark.last.id
    @save = save
  end

  def generate(n=1)
    generated=[]
    n.times do
      generated << make_one
    end
    generated
  end

  private

  def make_one(url: make_url, title: make_title, notes: make_notes, tags: make_tags)
    bookmark = @user.bookmarks.build(url: url, title: title, notes: notes, tag_list: tags)
    return bookmark unless @save
    if bookmark.save
      @last_id += 1
      bookmark
    end
  end

  def make_url
    Faker::Internet.url + "/#{@last_id + 1}"
  end

  def make_title
    Faker::Book.title + [" ", "|", "-"].shuffle.first + Faker::Company.catch_phrase
  end

  def make_notes
    Faker::Lorem.paragraph
  end

  def make_tags
    tags = ["rails", "web", "testing", "personal", "blogging", "work", "productivity"]
    tags.shuffle.first(rand(4)).join(",")
  end
end
