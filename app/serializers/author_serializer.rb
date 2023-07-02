# app/serializers/author_serializer.rb
class AuthorSerializer < ActiveModel::Serializer
  attributes :name
  has_one :profile
  has_many :posts

  def posts
    object.posts.map do |post|
      {
        title: post.title,
        short_content: truncate(post.content, length: 40),
        tags: post.tags.map { |tag| { name: tag.name } }
      }
    end
  end

  private

  def truncate(text, options = {})
    return text if text.length <= options[:length]

    truncated_text = text[0...options[:length]]
    truncated_text += '...' unless options[:skip_ellipsis]
    truncated_text
  end
end
